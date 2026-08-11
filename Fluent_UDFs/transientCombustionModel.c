/**********************************************************************
  transientCombustionModel.c 
  Header file containing Fluent User Defined Functions (UDFs) for a boundary condition pyrolysis model for transient combusiton: pyrolysis_release_rate, heat_absorption_rate, massSum
 ***********************************************************************/

#include "udf.h"
#include "math.h"

/*Constants in standard SI units*/
#define TA 30196 /*Activation temperature*/
#define A0 1.24e12 /*Pre-exponential term */
#define ETA 1.0 /*Reaction efficiency*/
#define TMIN 500.0 /*Minimum and maximum pyrolysis temperature */
#define TMAX 900.0
#define HOV 468000.0 /*Heat of vaporization*/

#define MSTORE 0 /*Memory Locations for mass and mass flux*/
#define MFSTORE 1

#define BCID 5 /*Boundary condition int ID for massSum*/

real rho = 457.5; /*Sample density*/
real thalf = 0.000215; /*Sample half thickness*/
real L = 0.305; /*Sample length*/
real W = 0.065; /*Sample width*/
real conc = 1.0; /*Mass concentration of cellulose in sample*/

int udmi_updated = 0; /*Memory update flag*/


/**********************************************************************
  pyrolysisReleaseRate.c 
  UDF for specifying a transient mass flux along the specified boundary as a function of temperature using finite rate chemistry 
 ***********************************************************************/

 DEFINE_PROFILE(pyrolysis_release_rate, thread, position)
 {
    static int initialized = 0;
    static real last_time   = -1.0;
    face_t f;
    real dt = CURRENT_TIMESTEP;
    int num_face = 0;
    int local_face = 0;

    if (CURRENT_TIME != last_time)
    {
      udmi_updated = 0;
      last_time = CURRENT_TIME;
    }

    /*Counts number of divisions along the geometry*/
    begin_f_loop(f, thread)
    {
      if (PRINCIPAL_FACE_P(f, thread))
        local_face++;
    }
    end_f_loop(f, thread)

    #if RP_NODE /*For summing with parallel nodes*/
      num_face = PRF_GISUM1(local_face);
    #else
      num_face = local_face;
    #endif

    if (num_face == 0) return;

    /*Pyrolysis rate profile set*/
    begin_f_loop(f, thread)
    {
      real Tface;
      real prr;
      real area[ND_ND];
      real A_mag;
      real init_mass;
      real remaining_mass;
      cell_t c0;
      Thread *t0;
      
      real dx = L/((real)num_face);

      if (!PRINCIPAL_FACE_P(f, thread)) continue;

      /* Face area magnitude*/
      F_AREA(area, f, thread);
      A_mag = NV_MAG(area); /*planar or axisymmetric*/
      /*A_mag = 2*M_PI*NV_MAG(area);*/

      if (A_mag < 1e-20)
      {
        F_PROFILE(f, thread, position) = 0.0; 
        continue;
      }

      /* Initial mass assigned to this face contribution */
      init_mass = conc*(rho * dx * W * thalf);

      /* Initialize mass and mflux memory once */
      if (!initialized)
      {
       F_UDMI(f, thread, MSTORE) = init_mass;
       F_UDMI(f,thread, MFSTORE) = 0.0;
      }
      
      remaining_mass = F_UDMI(f, thread, 0);
      
      /*Temperature from adjacent cell*/
      c0  = F_C0(f, thread);
      t0 = F_C0_THREAD(f, thread);
      Tface = C_T(c0, t0);

      if (Tface < 1.0) /*Check to prevent div by 0 and limit temp*/
      { 
       Tface = 1.0; 
      }
      else if (Tface > TMAX)
      {
        Tface = TMAX;
      }

      /* Fuel mass flux: kg/(s m^2) */
      real k = ETA * A0 * exp(-TA / Tface);
      real mflux = rho * thalf * k;

      /*Assigns release rate based on face mass to conserve mass*/
      if (remaining_mass <= 0.0 || Tface < TMIN)
      {
        F_PROFILE(f, thread, position) = 0.0;
        F_UDMI(f, thread, MFSTORE) = 0.0;
      }
      else if (remaining_mass < mflux * A_mag * dt)
      {
        F_PROFILE(f, thread, position) = remaining_mass / (A_mag * dt);
        if (!udmi_updated) 
        {
          F_UDMI(f, thread, MSTORE) = 0.0;
          F_UDMI(f, thread, MFSTORE) = remaining_mass / (A_mag * dt);
        }
          
      }
      else
      {
       F_PROFILE(f, thread, position) = mflux;
       if (!udmi_updated) 
       {
         F_UDMI(f, thread, MSTORE) = remaining_mass - mflux * A_mag * dt;
         F_UDMI(f, thread, MFSTORE) = mflux;
        }
      }
    }
    end_f_loop(f, thread)
    initialized = 1;
    udmi_updated = 1;
  }


/**********************************************************************
  heatAbsorptionRate.c 
  UDF for specifying a transient heat flux along the specified boundary as a function of the calculated mass flux
 ***********************************************************************/

DEFINE_PROFILE(heat_absorption_rate, thread, position)
 {
   #if !RP_HOST
     face_t f;
     real FCP;
     real Tface;
     cell_t c0;
     Thread *t0;
     begin_f_loop(f, thread)
     { 
       F_PROFILE(f, thread, position) = -(HOV + 100*(550)) * F_UDMI(f, thread, MFSTORE);
     }
     end_f_loop(f, thread)
   #endif
 }


/**********************************************************************
  massSum.c
  Tracks face masses, mass fluxes, and total mass and outputs each to a CSV every timestep
 ***********************************************************************/

DEFINE_EXECUTE_AT_END(massSum)
 {
   Domain *d = Get_Domain(1);
   Thread *t = Lookup_Thread(d, BCID);
   face_t f;
   real initMass = conc * rho * thalf * L * W;
   real timeTotalMass = 0.0;
   int  face_count;

   #if !RP_HOST
        
    face_count = THREAD_N_ELEMENTS_INT(t);
    
    begin_f_loop(f,t)
    {
      if (PRINCIPAL_FACE_P(f, t))
      {
        timeTotalMass += F_UDMI(f,t,0);
      }
    }
    end_f_loop(f,t)

    timeTotalMass = PRF_GRSUM1(timeTotalMass);
   #endif

   node_to_host_real_1(timeTotalMass); /*Pass variables from nodes to host*/
   node_to_host_int_1(face_count);

  
  if(I_AM_NODE_ZERO_P)
  { 
   int col;

   if (CURRENT_TIME < 1e-10)
   {
     FILE *fp = fopen("sample_mass_history.csv", "w"); //Total mass
     if (fp != NULL)
     {
      //header
       fprintf(fp, "time [s],sample mass [g]\n");
       fprintf(fp, "%g,%.4g\n", (real)0.0, initMass * 1000.0);
       fclose(fp);
     }

     else 
     {
       Message("massSum: Failed to open CSV for writing total mass.\n");
     }

     FILE *fa = fopen("face_mass_history.csv", "w"); //Individual mass
     if (fa != NULL)
     {
      //headers
       fprintf(fa, "time [s]");
       for (col = 0; col < face_count; col++)
         fprintf(fa, ",face_%d [g]", col+1);
       fprintf(fa, "\n");

       fprintf(fa, "%g", 0.0);
       begin_f_loop(f, t)
       {
         fprintf(fa, ",%.4g", initMass/((real) face_count));
       }
       end_f_loop(f, t)
       fprintf(fa, "\n");
       fclose(fa);
     }

     else 
     {
       Message("massSum: Failed to open CSV for writing face mass.\n");
     }
   }

   else
   {
     FILE *fp = fopen("sample_mass_history.csv", "a"); //Total mass
     if (fp != NULL)
     {
       fprintf(fp, "%g,%.4g\n", CURRENT_TIME, timeTotalMass * 1000.0);
       fclose(fp);
     }

     else
     {
       Message("massSum: Failed to open CSV for writing total mass.\n");
     }

     FILE *fa = fopen("face_mass_history.csv", "a"); //Individual mass
     if (fa != NULL)
     {
       fprintf(fa, "%g", CURRENT_TIME);
       begin_f_loop(f, t)
       {
         fprintf(fa, ",%.5g", F_UDMI(f,t,0) * 1000.0);
       }
       end_f_loop(f, t)
       fprintf(fa, "\n");
       fclose(fa);
     }

     else
     {
       Message("massSum: Failed to open CSV for writing face mass.\n");
     }
    }
  }
   
  #if !RP_HOST
   udmi_updated = 0;
  #endif
}
