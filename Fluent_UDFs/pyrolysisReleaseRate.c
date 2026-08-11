/**********************************************************************
  pyrolysisReleaseRate.c 
  UDF for specifying a transient fuel release rate
 ***********************************************************************/
 
 #include "udf.h"
 #include "math.h"

 /*Constants in standard SI units*/
 #define TA 30196 /*Activation temperature*/
 #define A0 1.24e12 /*Pre-exponential term */
 #define ETA 1.0 /*Reaction efficiency*/
 #define TMIN 500.0 /*Minimum and maximum pyrolysis temperature */
 #define TMAX 900.0
 #define MSTORE 0
 #define MFSTORE 1

 real rho = 457.5; /*Sample density*/
 real thalf = 0.000215; /*Sample half thickness*/
 real L = 0.305; /*Sample length*/
 real W = 0.065; /*Sample width*/
 real conc = 1.0; /*Mass concentration of cellulose in sample*/

 int udmi_updated = 0;

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