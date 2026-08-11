/**********************************************************************
  heatAbsorptionRate.c 
  UDF for specifying a transient fuel release rate
 ***********************************************************************/
 
 #include "udf.h"
 
 #define MFSTORE 1
 #define HOV 468000.0
 #define TMAX 850
 #define TINF 300

 DEFINE_PROFILE(heat_absorption_rate, thread, position)
 {
   #if !RP_HOST
     face_t f;
     real FCP;
     real Tface;
     cell_t c0;
     Thread *t0;
     /*
     c0  = F_C0(f, thread);
     t0 = F_C0_THREAD(f, thread);
     Tface = C_T(c0, t0);

     if (Tface < 1.0) /*Check to prevent div by 0 and limit temp
      { 
       Tface = 1.0; 
      }
      else if (Tface > TMAX)
      {
       Tface = TMAX;
      }
      */
      begin_f_loop(f, thread)
      { 
        F_PROFILE(f, thread, position) = -(HOV + 100*(550)) * F_UDMI(f, thread, MFSTORE);
      }
      end_f_loop(f, thread)
    #endif
  }