#include"matrix.h"
#include<cmath>
#include<iostream>
#include <algorithm>
using namespace std;

double current_pssm_gc;
double snd_pssm[4];
vector<double> temp_row(4,0);

motifMatrix temp_mat;

vector<class motifMatrix> pssm_motif_matrices;
vector<class motifMatrix> temp_pssm_motif_matrices;


vector<double> calc_weight(vector<double> & mat_row){

	// calculating single neucleotide distributions .. ie A,C,G,T from the gc
	snd_pssm[0]=(1-current_pssm_gc)/2;
	snd_pssm[1]=current_pssm_gc/2;
	snd_pssm[2]=current_pssm_gc/2;
	snd_pssm[3]=(1-current_pssm_gc)/2;

	// loop over cells (4 letters) in the given position
	for(int alpha=0;alpha<4;alpha++) {
		temp_row[alpha]=log((mat_row[alpha])/snd_pssm[alpha]); //log is ln !!
	}
	return temp_row;

}

void Convert_to_Pssm(const motifMatrix & matrix){

	motifMatrix tmp_matrix=matrix;				// temporary object for the matrix

	if (!GC_RANGE){
		current_pssm_gc = tmp_matrix.gc; //using matrix-specific GC
	}

	transform(tmp_matrix.weight.begin(),tmp_matrix.weight.end(),	// loop over all the positionsin the matrix
			tmp_matrix.weight.begin(),
			calc_weight);

	if (GC_RANGE){
		tmp_matrix.gc=snd_pssm[1]+snd_pssm[2];		       // store the GC used to calculate the store matrix
	}
	tmp_matrix.type = "pssm";
	temp_pssm_motif_matrices.push_back(tmp_matrix);	     	// push the modified matrix into a temporary list
	tmp_matrix.weight.clear();
}

//==========================================================================================
void pspm_to_pssm(const double & gc_cont){

	current_pssm_gc = gc_cont;

	for_each(motif_matrices.begin(),motif_matrices.end(),	// looping over all the matrices to be converted into score matrices
			Convert_to_Pssm);				// with the specfied GC

}
//==========================================================================================
void pspms_to_pssms(){
	if (GC_RANGE){
		for_each(GC_vector.begin(),GC_vector.end(),pspm_to_pssm);	// loop over all the GC_vector list
	} else {
		for_each(motif_matrices.begin(),motif_matrices.end(),	// looping over all the matrices to be converted into score matrices
				Convert_to_Pssm);
	}

	motif_matrices=temp_pssm_motif_matrices;		      	// storing the modified matrix list in the original motif_matrices
	temp_pssm_motif_matrices.clear();
}
