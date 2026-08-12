/**********************************************************************
  massSum.c
  Sums remaining discretized mass and outputs to CSV every timestep
 ***********************************************************************/

#include "udf.h"

#define BCID      5
#define MAX_FACES 500

extern real rho;
extern real thalf;
extern real L;
extern real W;
extern real conc;
extern int  udmi_updated;

DEFINE_EXECUTE_AT_END(massSum)
{
  Domain *d     = Get_Domain(1);
  Thread *t     = Lookup_Thread(d, BCID);
  face_t f;
  real initMass = conc * rho * thalf * L * W;
  int i, j;

#if !RP_HOST

  real  localMass  = 0.0;
  int   localCount = 0;
  real *localFaces;

  /* Count local principal faces */
  begin_f_loop(f, t)
  {
    if (PRINCIPAL_FACE_P(f, t))
      localCount++;
  }
  end_f_loop(f, t)

  /* Allocate and fill local face mass array using counter not face ID */
  localFaces = (real *)malloc(localCount * sizeof(real));
  i = 0;
  begin_f_loop(f, t)
  {
    if (PRINCIPAL_FACE_P(f, t))
    {
      localFaces[i]  = F_UDMI(f, t, 0);
      localMass     += F_UDMI(f, t, 0);
      i++;
    }
  }
  end_f_loop(f, t)

  /* Nodes 1,2,... send their data to node 0 */
  if (!I_AM_NODE_ZERO_P)
  {
    PRF_CSEND_INT(node_zero,  &localCount, 1,          myid);
    PRF_CSEND_REAL(node_zero,  localFaces, localCount, myid);
    PRF_CSEND_REAL(node_zero, &localMass,  1,          myid);
  }
  else
  {
    /* Node 0 builds global arrays starting with its own data */
    real  globalMass  = localMass;
    int   totalCount  = localCount;
    real  allFaces[MAX_FACES];
    int   recvCount;
    real  recvMass;
    real *recvFaces;

    for (j = 0; j < MAX_FACES; j++)  allFaces[j] = 0.0;
    for (j = 0; j < localCount; j++) allFaces[j] = localFaces[j];

    int offset = localCount;

    /* Receive from nodes 1,2,... and append to allFaces */
    compute_node_loop_not_zero(i)
    {
      PRF_CRECV_INT(i,  &recvCount, 1,         i);
      recvFaces = (real *)malloc(recvCount * sizeof(real));
      PRF_CRECV_REAL(i,  recvFaces,  recvCount, i);
      PRF_CRECV_REAL(i, &recvMass,   1,          i);

      globalMass += recvMass;
      for (j = 0; j < recvCount && (offset + j) < MAX_FACES; j++)
        allFaces[offset + j] = recvFaces[j];
      offset     += recvCount;
      totalCount += recvCount;

      free(recvFaces);
    }

    /* Node 0 writes directly to CSV */
    {
      int  col;
      FILE *fp, *fa;

      if (CURRENT_TIME < 1e-10)
      {
        fp = fopen("sample_mass_history.csv", "w");
        if (fp != NULL)
        {
          fprintf(fp, "time [s],sample mass [g]\n");
          fprintf(fp, "%g,%.4g\n", 0.0, initMass * 1000.0);
          fclose(fp);
        }
        else { Message("massSum: Failed to open sample_mass_history.csv.\n"); }

        fa = fopen("face_mass_history.csv", "w");
        if (fa != NULL)
        {
          fprintf(fa, "time [s]");
          for (col = 0; col < totalCount; col++)
            fprintf(fa, ",face_%d [mg]", col + 1);
          fprintf(fa, "\n");

          fprintf(fa, "%g", 0.0);
          for (col = 0; col < totalCount; col++)
            fprintf(fa, ",%.4g", allFaces[col] * 1000000.0);
          fprintf(fa, "\n");
          fclose(fa);
        }
        else { Message("massSum: Failed to open face_mass_history.csv.\n"); }
      }
      else
      {
        fp = fopen("sample_mass_history.csv", "a");
        if (fp != NULL)
        {
          fprintf(fp, "%g,%.4g\n", CURRENT_TIME, globalMass * 1000.0);
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
      }
    }
  }

  free(localFaces);
  udmi_updated = 0;

#endif /* !RP_HOST */
}