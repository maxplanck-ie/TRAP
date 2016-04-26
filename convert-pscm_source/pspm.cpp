#include"matrix.h"
#include <algorithm>

double total_exp=0;

vector<double> calc_exp_prob(vector<double> & mat_row){
	
  total_exp=mat_row[0]+mat_row[1]+mat_row[2]+mat_row[3];	// sum of all cell in the given position
  // loop over the cells to convert into position matrix
  for(int alpha=0;alpha<4;alpha++)						
    mat_row[alpha]=(mat_row[alpha]+pscount)/(total_exp+pscount*4);
  return mat_row;
}


motifMatrix Convert_to_Pspm(motifMatrix & matrix){

  transform(matrix.weight.begin(),matrix.weight.end(),	// loop over all the positions in a matrices for modification or positions
	    matrix.weight.begin(),
	    calc_exp_prob);
  return matrix;
}


void pscms_to_pspms(){
	
  transform(motif_matrices.begin(),motif_matrices.end(), // loop over the motif matrices list for conversion to position matrices
	    motif_matrices.begin(),
	    Convert_to_Pspm);
  
}

