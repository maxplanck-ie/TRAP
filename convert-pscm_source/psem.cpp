#include"matrix.h"
#include<cmath>
#include<iostream>
#include <algorithm>

using namespace std;

int kk;
double current_gc;
double snd[4];
vector<class motifMatrix> psem_motif_matrices;
vector<class motifMatrix> tmp_motif_matrices;

class calc_ratio{

public:
  double background[4];
  vector <int> consensus;
  vector <double> temp_MatRow;
  vector<int> MULT_CONS_FLAG;

  calc_ratio(vector<int>& con,vector<int>& mul_con){consensus=con;MULT_CONS_FLAG=mul_con;};
  
  vector<double> operator() (vector<double> & mat_row){
    
	  // calculating single nucleotide distributions .. ie A,C,G,T from the GC in the list
	  snd[0]=(1-current_gc)/2;
	  snd[1]=current_gc/2;
	  snd[2]=current_gc/2;
	  snd[3]=(1-current_gc)/2;
    
    temp_MatRow=mat_row;
    // modyfying the row without background frequency.			
    for(int alpha=0;alpha<4;alpha++)
      temp_MatRow[alpha]=log((mat_row[consensus[kk]]+pscount)/(mat_row[alpha]+pscount))/fact_lambda;
    
    // calculate the background frequency
    
    //calculate the background frequency in case of NO MULTIPLE CONSENSUS entries
    if(MULT_CONS_FLAG[kk]==0){	
      for(int alpha=0;alpha<4;alpha++)
	background[alpha]=log(snd[alpha]/snd[consensus[kk]])/fact_lambda;
      //cout<<snd[alpha]<<"\t"<<snd[consensus[kk]]<<"\t"<<background[alpha]<<endl;
    }
    else{
      for(int alpha=0;alpha<4;alpha++)
	background[alpha]=log(snd[alpha]/snd[consensus[kk]])/fact_lambda;
      
    }
    // add background frequency to the result if needed
    for(int alpha=0;alpha<4;alpha++)
      temp_MatRow[alpha]+=background[alpha];
    
    kk++;
    return temp_MatRow;
  }
};

void Convert_to_psem(const motifMatrix & matrix){
  kk=0;
  motifMatrix tmp_matrix=matrix;
  
  if (!GC_RANGE){
	  current_gc = tmp_matrix.gc; //using matrix-specific GC
    }

  transform(tmp_matrix.weight.begin(),tmp_matrix.weight.end(),	// loop through the positions in the matrix to modify
	    tmp_matrix.weight.begin(),				// score matrix tp energy matrix
	    calc_ratio(tmp_matrix.consensus,tmp_matrix.mult_consensus));
  
  if (GC_RANGE){
	  tmp_matrix.gc=snd[1]+snd[2];	             //storing the gc used to calculate the matrix
  }
  tmp_matrix.type = "psem";
  tmp_motif_matrices.push_back(tmp_matrix);  // pushin the mtrix into a temporary list 
  tmp_matrix.weight.clear();
  
}



//==========================================================================================
void pscm_to_psem(const double & gc_cont){

  current_gc = gc_cont;
  for_each(motif_matrices.begin(),motif_matrices.end(),	Convert_to_psem); // loop over the matrices to calculate energy matrices
}

void pscms_to_psems(){
	if (GC_RANGE){
		for_each(GC_vector.begin(),GC_vector.end(),pscm_to_psem); //looping through the GC_vector_list
	} else {
		for_each(motif_matrices.begin(),motif_matrices.end(), Convert_to_psem); //use matrix-specific gc
	}
	motif_matrices=tmp_motif_matrices;
	tmp_motif_matrices.clear();
  //cout << "pscms_to_psems: generated matrices " << motif_matrices.size() << endl; exit(1);
}
