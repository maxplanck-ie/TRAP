#include"matrix.h"
#include<cmath>
#include<iostream>
#include <algorithm>
using namespace std;

int valMaxCol;
double valMax = -100;
double valMin = 100;
vector<int> temp_max_values;
vector<int> temp_mult_consensus;
///////////////-----------------------------------------------------/////////////////////////
void analyze_matrix_properties(){
	transform(motif_matrices.begin(),motif_matrices.end(),motif_matrices.begin(),analyze_individual_matrices_annotate_fast);
}

///////////////-----------------------------------------------------/////////////////////////
motifMatrix analyze_individual_matrices_annotate_fast(motifMatrix & matrix){
	temp_max_values.clear();
	valMax = -100;
	valMin =100;

	// calculate consensus
	temp_mult_consensus.clear();
	for_each(matrix.weight.begin(),matrix.weight.end(),getConsensus);
	matrix.consensus=temp_max_values;
	matrix.mult_consensus=temp_mult_consensus;
	matrices_identities_map[matrix.id]=true;
	//mask value
	matrix.mask_value = valMax;// temporarily set the masking value to the maximum of the matrix
	matrix.min_value = valMin;// store min value
	matrix.max_value = valMax;// store min value

	//cout << "max value: "<< matrix.max_value << " min value "<< matrix.min_value <<endl;
	return matrix;
}

///////////////-----------------------------------------------------/////////////////////////
void getConsensus(const vector<double>& row){
	double max_val=-100;
	valMaxCol=-1;


	//get the maximum value in each position (= each row)
	for(int i=0;i<4;i++){
		if(row[i]>max_val){
			valMaxCol=i;
			max_val=row[i];
		}
		if (row[i]<valMin){
			valMin = row[i];
		}
	}

	temp_max_values.push_back(valMaxCol);

	//deal with multiple highest values
	for(int i=0;i<4;i++){
		if(row[i]==max_val && i!=valMaxCol && (valMaxCol==0 && i!=3) && (valMaxCol==3 && i!=0)
		&& (valMaxCol==1 && i!=2) && (valMaxCol==2 && i!=1)  ){
			temp_mult_consensus.push_back(1);
		}
		else
		temp_mult_consensus.push_back(0);
	}

	//get maximum value for the matrix
	if(max_val>valMax){
		valMax = max_val; // max_val is maximum for the current row
	}
}

