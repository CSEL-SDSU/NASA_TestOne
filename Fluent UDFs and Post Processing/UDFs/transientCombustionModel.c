/**********************************************************************
  transientCombustionModel.c 
  Header file containing Fluent User Defined Functions (UDFs) for a boundary condition pyrolysis model for transient combusiton: pyrolysis_release_rate, heat_absorption_rate, massSum
  !Caution massSum will overwrite the three csv files it outputs if they are not moved or renamed!
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

#define BCID 5 /*Boundary condition int ID for massSum and maximum number of faces on the boundary*/
#define MAX_FACES 500

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
    #if !RP_HOST
    static int initialized = 0;
    static real last_time   = -1.0;
    face_t f;
    real dt = CURRENT_TIMESTEP;
    int num_face = 0;
    int local_face = 0;

    if (CURRENT_TIME != last_time) //Sets flag based on if timestep has changed or not
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
      
    num_face = PRF_GISUM1(local_face);
    real dx = L/((real)num_face);

    /*Pyrolysis rate profile set*/
    begin_f_loop(f, thread)
    {
      real Tface;
      real prr;
      real area[ND_ND];
      real A_mag;
      real init_mass;
      real remaining_mass;

      /* Face area magnitude*/
      F_AREA(area, f, thread);
      A_mag = NV_MAG(area); /*planar or axisymmetric*/
      /*A_mag = 2*M_PI*NV_MAG(area);*/

      /* Initial mass assigned to this face contribution */
      init_mass = conc*(rho * dx * W * thalf);

      /* Initialize mass and mflux memory once */
      if (!initialized)
      {
       F_UDMI(f, thread, MSTORE) = init_mass;
       F_UDMI(f,thread, MFSTORE) = 0.0;
      }
      
      remaining_mass = F_UDMI(f, thread, 0);
      
      Tface = F_T(f, thread);

      if (Tface > TMAX)
      {
        Tface = TMAX;
      }

      /* Fuel mass flux: kg/(s m^2) */
      real k = ETA * A0 * exp(-TA / Tface);
      real mflux = rho * thalf * k;

      /*Assigns mass flux based on face mass to ensure mass conservation*/
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
    #endif
  }


/**********************************************************************
  heatAbsorptionRate.c 
  UDF for specifying a transient heat flux along the specified boundary as a function of the calculated mass flux
 ***********************************************************************/

DEFINE_PROFILE(heat_absorption_rate, thread, position)
 {
   #if !RP_HOST
     face_t f;

     begin_f_loop(f, thread)
     { 
       F_PROFILE(f, thread, position) = -(HOV + 100*(550)) * F_UDMI(f, thread, MFSTORE); //HOV added to approximate amount of heat required to heat sample to vaporization temp multiplied by mass flux
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
  Domain *d = Get_Domain(1); //To get thread for face loops
  Thread *t = Lookup_Thread(d, BCID);
  face_t f;
  real initMass = conc * rho * thalf * L * W;
  int i, j;

#if !RP_HOST

  real localMass  = 0.0;
  int localCount = 0;
  real centroid[ND_ND];
  real *localFaces;
  real *localFlux;
  real *localCentroid;

  //Counts faces on thread
  begin_f_loop(f, t)
  {
    if (PRINCIPAL_FACE_P(f, t))
      localCount++;
  }
  end_f_loop(f, t)

  //Initial matrix sizing
  localFaces = (real *)malloc(localCount * sizeof(real));
  localFlux = (real *)malloc(localCount * sizeof(real));
  localCentroid = (real *)malloc(localCount * sizeof(real));
  
  i = 0;
  begin_f_loop(f, t) //Access user memory at every face
  {
    if (PRINCIPAL_FACE_P(f, t))
    {
      F_CENTROID(centroid, f, t);
      localCentroid = centroid[1];
      localFaces[i] = F_UDMI(f, t, MSTORE);
      localFlux[i] = F_UDMI(f, t, MFSTORE);
      localMass += F_UDMI(f, t, MSTORE);
      i++;
    }
  }
  end_f_loop(f, t)

  if (!I_AM_NODE_ZERO_P) //Sends local node data to node 0
  {
    PRF_CSEND_INT(node_zero, &localCount, 1, myid);
    PRF_CSEND_REAL(node_zero, localFaces, localCount, myid);
    PRF_CSEND_REAL(node_zero, localFlux, localCount, myid);
    PRF_CSEND_REAL(node_zero, localCentroid, localCount, myid);
    PRF_CSEND_REAL(node_zero, &localMass, 1, myid);
  }
  else
  {
    real globalMass = localMass;
    int totalCount = localCount;
    real allFaces[MAX_FACES];
    real allFlux[MAX_FACES];
    real faceCentroid[MAX_FACES];
    int recvCount;
    real recvMass;
    real *recvFaces;
    real *recvFlux;
    real *recvCentroid;
    int col;
    FILE *fp, *fa, *ff;

    for (j = 0; j < localCount; j++)
    {
      allFaces[j] = localFaces[j];
      allFlux[j] = localFlux[j];
      faceCentroid[j]  = localCentroid[j];
    }

    int offset = localCount;

    compute_node_loop_not_zero(i) //Allocates memeory for temporary arrays for data from each node
    {
      PRF_CRECV_INT(i, &recvCount, 1, i);
      recvFaces = (real *)malloc(recvCount * sizeof(real));
      recvFlux = (real *)malloc(recvCount * sizeof(real));
      recvCentroid = (real *)malloc(recvCount * sizeof(real));
      PRF_CRECV_REAL(i, recvFaces, recvCount, i);
      PRF_CRECV_REAL(i, recvFlux, recvCount, i);
      PRF_CRECV_REAL(i, recvCentroid,   recvCount, i);
      PRF_CRECV_REAL(i, &recvMass, 1, i);

      globalMass += recvMass;
      for (j = 0; j < recvCount && (offset + j) < MAX_FACES; j++) //Organizes data and stores to output array
      {
        allFaces[offset + j] = recvFaces[j];
        allFlux[offset + j] = recvFlux[j];
        faceCentroid[offset + j]  = recvCentroid[j];
      }
      offset += recvCount; 
      totalCount += recvCount; 

      free(recvFaces);
      free(recvFlux);
      free(recvCentroid);
    }

    if (CURRENT_TIME < 1e-10) //Creates csv and prints headers for each file at calculation start and then prints data for every timestep
    {
      fp = fopen("sample_mass_history.csv", "w");
      if (fp != NULL)
      {
        fprintf(fp, "time [s],sample mass [g]\n");
        fprintf(fp, "%g,%.6g\n", 0.0, initMass * 1000.0);
        fclose(fp);
      }
      else { Message("massSum: Failed to open sample_mass_history.csv.\n"); }

      fa = fopen("face_mass_history.csv", "w");
      if (fa != NULL)
      {
        fprintf(fa, "time [s]");
        for (col = 0; col < totalCount; col++)
          fprintf(fa, ",%.4g [mm]", faceCentroid[col]*1000.0);
        fprintf(fa, "\n");

        fprintf(fa, "%g", 0.0);
        for (col = 0; col < totalCount; col++)
          fprintf(fa, ",%.4g", allFaces[col] * 1000000.0);
        fprintf(fa, "\n");
        fclose(fa);
      }
      else { Message("massSum: Failed to open face_mass_history.csv.\n"); }

      ff = fopen("face_flux_history.csv", "w");
      if (ff != NULL)
      {
        fprintf(ff, "time [s]");
        for (col = 0; col < totalCount; col++)
          fprintf(ff, ",%.4g [mm]", faceCentroid[col]*1000.0);
        fprintf(ff, "\n");

        fprintf(ff, "%g", 0.0);
        for (col = 0; col < totalCount; col++)
          fprintf(ff, ",%.4g", allFlux[col]);
        fprintf(ff, "\n");
        fclose(ff);
      }
      else { Message("massSum: Failed to open face_flux_history.csv.\n"); }
    }
    else
    {
      fp = fopen("sample_mass_history.csv", "a");
      if (fp != NULL)
      {
        fprintf(fp, "%g,%.6g\n", CURRENT_TIME, globalMass * 1000.0);
        fclose(fp);
      }
      else { Message("massSum: Failed to append to sample_mass_history.csv.\n"); }

      fa = fopen("face_mass_history.csv", "a");
      if (fa != NULL)
      {
        fprintf(fa, "%g", CURRENT_TIME);
        for (col = 0; col < totalCount; col++)
          fprintf(fa, ",%.4g", allFaces[col] * 1000000.0);
        fprintf(fa, "\n");
        fclose(fa);
      }
      else { Message("massSum: Failed to append to face_mass_history.csv.\n"); }

      ff = fopen("face_flux_history.csv", "a");
      if (ff != NULL)
      {
        fprintf(ff, "%g", CURRENT_TIME);
        for (col = 0; col < totalCount; col++)
          fprintf(ff, ",%.4g", allFlux[col]);
        fprintf(ff, "\n");
        fclose(ff);
      }
      else { Message("massSum: Failed to append to face_flux_history.csv.\n"); }
    }
  }

  free(localFaces);
  free(localFlux);
  free(localCentroid);
  udmi_updated = 0;

#endif
}
