#ifndef ANNOTATE_SEQUENCE_H_
#define ANNOTATE_SEQUENCE_H_

extern long region_size;
extern int region_shift;
extern int number_of_top_scores;
extern bool DEF_GC;
extern bool AFFINITY_SCORE;
extern bool USER_SHIFT;
extern bool DEBUG;

void annotate_sequence();
void calc_hits();
void calc_affinities();

void  print_score();
void shift_correction();
void calc_pssm_matrices();
void calc_psem_matrices();
void pick_pssm_matrices();
void pick_psem_matrices();

#endif /*ANNOTATE_SEQUENCE_H_*/
