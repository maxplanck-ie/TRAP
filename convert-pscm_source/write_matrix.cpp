#include<vector>
#include<string>
#include<iostream>
#include<algorithm>
#include"matrix.h"

using std::cout;
using std::cerr;
using std::endl;

extern std::ostream *user_out_file;


//function declarations for this class
void print_all_matrices();
void print_matrix(motifMatrix & matrix);
void print_row(const vector<double>& row);


///////////////-----------------------------------------------------/////////////////////////
void print_all_matrices(){
	for_each(motif_matrices.begin(),motif_matrices.end(),print_matrix);
}
///////////////-----------------------------------------------------/////////////////////////
// routine to print the matrices
void print_matrix(motifMatrix & matrix){

	//discard reversed matrix by default
	if(!matrix.strand.compare("-") && PRINT_BOTH == false ){
		// do nothing
	} else {

		// start matrix header
		*user_out_file << ">"<< matrix.id << " ";
		*user_out_file << "/name='"<< matrix.TF_name << "' ";
		*user_out_file << "/type='"<< matrix.type<< "' ";
		*user_out_file << "/strand='"<< matrix.strand<< "' ";
		*user_out_file << "/size='"<< matrix.motif_length<< "' ";
		*user_out_file << "/gc='"<< matrix.gc << "' ";
		*user_out_file << "/pseudocount='"<< pscount << "' ";

		if (matrix.type == "pssm" && matrix.score_cutoff!=0) {
			*user_out_file << "/cutoff='"<< matrix.score_cutoff << "' ";
		}
		if (matrix.type == "psem") {
			*user_out_file << "/lambda='"<< matrix.lambda << "' ";
			*user_out_file << "/pseudocount='"<< pscount << "' ";
		}
		// rest of matrix parameters
		for( matrix.params_iter = matrix.matrix_params.begin(); matrix.params_iter != matrix.matrix_params.end(); ++matrix.params_iter ) {
			// skip already written params
			if (!matrix.params_iter->first.compare("name") ||
					!matrix.params_iter->first.compare("strand")||
					!matrix.params_iter->first.compare("size")||
					!matrix.params_iter->first.compare("type")||
					!matrix.params_iter->first.compare("pseudocount")||
					!matrix.params_iter->first.compare("gc")) {
				continue;
			} else {
				// print other params
				*user_out_file << " /" << matrix.params_iter->first << "='" << matrix.params_iter->second <<"'";
			}
		}
		*user_out_file << endl;

		//matrix cells
		for_each(matrix.weight.begin(),matrix.weight.end(),print_row);
	}
}

///////////////-----------------------------------------------------/////////////////////////
// routine to print the matrices
void print_row(const vector<double>& row){
	//iterate each nucleotdie
	for(int i=0;i<4;i++){
		*user_out_file << row[i] << "\t";
	}
	*user_out_file << endl;
}


