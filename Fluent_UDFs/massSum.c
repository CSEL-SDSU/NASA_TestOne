/**********************************************************************
  massSum.c
  Sums remaining discretized mass and outputs to CSV every timestep
 ***********************************************************************/

 #include "udf.h"

 #define BCID 5

 extern real rho;
 extern real thalf;
 extern real L;
 extern real W;
 extern real conc;
 extern int  udmi_updated;

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
       Message("Should've printed\n");

       fprintf(fa, "%g", 0.0);
       begin_f_loop(f, t)
       {
         fprintf(fa, ",%.4g", initMass/((real) face_count));
         Message("Looping...\n");
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