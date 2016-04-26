#ifndef SCORE_CALC_H_
#define SCORE_CALC_H_

#ifndef VECTOR_H_
#include<vector>
#endif

extern bool LARGEST;
extern bool FACT_LAMDA;
extern bool FACT_LNR0;
extern bool MASK_SCORING;
extern bool DISCARD_POS;
extern bool TABLE;
extern bool ANNOTATION_AVERAGE;

extern double fact_lnR0;

extern vector<long> temp_sequence_start;
extern vector<long> temp_sequence_end;
extern vector<double> largest_score;

extern vector<int> discard_pos;

// each matrix comes with a vector of top-ranking scores and their corresponding starts and ends
extern vector< vector<double> > top_scores;
extern vector< vector<long> >   top_starts;
extern vector< vector<long> >   top_ends;    // used only for score_calc_region_top()

void score_calc_bindSite();	    //scans the current sequence region with all factors and ouputs hits as gff
void score_calc_bindSite_debug();   // same, but with debugging information
void score_calc_bindSite_largest(); // does not print but collects the largest hits (strand/anti-strand) for each matrix in 
void score_calc_bindSite_top();	    //collects the  largest scores and the corresponding starts


void score_calc_region();	    
void score_calc_region_largest();
void score_calc_region_top();

void matrices_mask_scoring(); // handling of masked regions

#endif /*SCORE_CALC_H_*/
