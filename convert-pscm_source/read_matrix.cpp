#include<fstream>
#include<vector>
#include<string>
#include<iostream>
#include<algorithm>
#include"matrix.h"
#include <cstdlib>
#include "string.h"

using std::cout;
using std::cerr;
using std::endl;
using std::ifstream;

#define mat_line_LENGTH 200

//function declarations for this class
void read_matrix_file(char* mat_file_name);
void get_first_matrix_file_line();
void next_mat();
void matrix_header_tokenize(char *);
void matrix_set_parameters();
void adapt_matrix_params();
void store_matrix();
bool IsElement (string TF_name, vector<string> name_flags );

//variables
bool NAME = false;
ifstream matfile;

vector <class motifMatrix> motif_matrices;

vector<double>::iterator min_position_iterator;
map <string,bool> matrices_identities_map;
motifMatrix score_mat_forw,score_mat_back;

char mat_line[1000];					// pointer to the tokens
double max_val=-1;
double a_num,c_num,g_num,t_num,gc_tmp_double;
int list_size=0;
int motif_length=0;
bool CUTOFF_FILE = false;
bool GC_FILE = false;
bool LNR0_FILE = false;
bool LAMBDA_FILE = false;

//================================================================
void read_matrix_file(char* mat_file_name){

	matfile.open(mat_file_name);        // reading the matrix file

	if(!matfile){
		// checking for the availibility of the file
		cerr<<"ERROR: Matrix file not present\n";
		exit(1);

	} else{

		std::vector<double> mat_row;     // vector containing temporary row elements
		const char *a_base,*c_base,*g_base,*t_base,*comment;   // pointer to each base score

		//read the matrix file

		//first matrix
		get_first_matrix_file_line();  //reads file until first header ">" is seen
		matrix_header_tokenize(mat_line);
		matrix_set_parameters();
		adapt_matrix_params();
		score_mat_back = score_mat_forw; //copy the forward into the reverse

		while(matfile.getline(mat_line,1000,'\n')!=NULL){

			if ((mat_line[0] == '\0') || (mat_line[0] == ';'))
				// skipping empty mat_lines if any
				continue;


			//next matrix found,
			else if(mat_line[0]=='>'){ // checking for > in a mat_line for the start of new matrix

				// end previous matrix
				if ( IsElement(score_mat_forw.TF_name, name_flags) ||
						IsElement(score_mat_forw.id, name_flags) ) {
				store_matrix();
				}

				//reinitialize
				score_mat_forw.clear_matrix_values();
				motif_length = 0;

				// start handling new matrix
				matrix_header_tokenize(mat_line);
				matrix_set_parameters();
				adapt_matrix_params();
				score_mat_back = score_mat_forw; //copy the forward into the reverse

				continue;
			}

			// contnuing with the loop to the next mat_line of the file
			else{

				// splitting the matrix rows into tokens
				a_base=strtok(mat_line," \t");
				c_base=strtok(NULL," \t");
				g_base=strtok(NULL," \t");
				t_base=strtok(NULL," \t");
				comment=strtok(NULL," \t");

				//converting then into float from string char
				a_num=atof(a_base);
				c_num=atof(c_base);
				g_num=atof(g_base);
				t_num=atof(t_base);

				// catch for -ve values	in case of PSCM
				if(PSCM && (a_num <0 || c_num<0 || g_num < 0 || t_num < 0) ){
					string neg_error="ERROR: NEGATIVE VALUE NOT APPLICABLE IN COUNT MATRIX: "+ score_mat_forw.id;
					cerr << neg_error << endl;
					exit(1);
				}
				// pushing the values into a temporary vector for forward strand
				mat_row.push_back(a_num);
				mat_row.push_back(c_num);
				mat_row.push_back(g_num);
				mat_row.push_back(t_num);

				// pushing the row into the matrix vector for the forward strand
				score_mat_forw.weight.push_back(mat_row);
				//reversing the vector for backward strand
				reverse(mat_row.begin(),mat_row.end());
				//pushing the row into the matrix vector for the backward strand
				score_mat_back.weight.push_back(mat_row);

				motif_length++;
			}
			mat_row.clear();
		}

		// in case of the last matrix of the file
		if ( IsElement(score_mat_forw.TF_name, name_flags) ||
				IsElement(score_mat_forw.id, name_flags)  ) {
			store_matrix();
		}

		//reinitialize
		score_mat_forw.clear_matrix_values();
		score_mat_back.clear_matrix_values();

	}
}
///////////////-----------------------------------------------------/////////////////////////
// search for the begining of the 1st line begining with '>'
void get_first_matrix_file_line(){
  do{
    matfile.getline(mat_line,1000,'\n');					// reading the first mat_line
  }
  while(mat_line[0]!='>');
}

///////////////-----------------------------------------------------/////////////////////////
// routine to skip a matrix and start reading from the next matrix onwards
void next_mat(){
  char nt;
  matfile.get(nt);
  // loop till the next header begining or the end of matrix fasta file
  while(!matfile.eof() && nt!='>')
    matfile.get(nt);
  // trace back the character
  if(nt=='>')
    matfile.seekg(-1,std::ios::cur);
}

///////////////-----------------------------------------------------/////////////////////////
// matrix header tokenizer function
void matrix_header_tokenize(char *mat_line){

	const char *token;
	string key, value;
	token=strtok(mat_line," \t"); // space or tab

	while(token!=NULL){

		// check for the ID information in the header
		if(token[0]=='>'){
			score_mat_forw.id=token;
			score_mat_forw.id.erase(0,1);
			token=strtok(NULL," \t");
		}
		// process all remaining informations
		else if(strstr(token,"/")){

			//1- get key
			key =token;
			if( key.find_first_of(":") != string::npos ) {
				key.resize(key.find_first_of(":")); // cut from ":"
				key.erase(0,1); //remove the first character
			}
			else if( key.find_first_of("=") != string::npos ) {
				key.resize(key.find_first_of("=")); // cut from "="
				key.erase(0,1);
			}

			//2- get value
			if(strstr(token,":")){
				value = token;
				value.erase(0,strcspn(token,":")+1); // erase everything before token
			}
			else if(strstr(token,"=")){
				value = token;
				value.erase(0,strcspn(token,"=")+1);
			}

			// remove the '' of value if necessary
			if (value.substr(0,1).compare("'") == 0) { //first occurence
				value.erase(0,1);
			}
			if (value.substr(value.length()-1,value.length()).compare("'") == 0) { //last occurence
				value.erase(value.length()-1,value.length());
			}
			token=strtok(NULL," \t");

			//3-  store all parameters in the matrix
			score_mat_forw.matrix_params[key] = value;
		} else {
			// tokenize the other redundant data in the header line
			token=strtok(NULL," \t");
		}
	}
}
///////////////-----------------------------------------------------/////////////////////////
// stores parameters read from the matrix header within the matrix object
void matrix_set_parameters(){

	//initialize flags
	CUTOFF_FILE = false;
	GC_FILE = false;
	LNR0_FILE = false;
	LAMBDA_FILE = false;

	//type
	if (score_mat_forw.matrix_params.count("type") > 0) {
		score_mat_forw.type = score_mat_forw.matrix_params["type"];
	} else {
		if (PSCM) {
				score_mat_forw.type = "pscm";
			}
			if (PSSM) {
				score_mat_forw.type = "pssm";
			}
	}

	//name
	NAME=false;
	if (score_mat_forw.matrix_params.count("name") > 0) {
		score_mat_forw.TF_name = score_mat_forw.matrix_params["name"];
		NAME=true;
	}
	// if NAME is not specified in the matrix file
	if(!NAME){
		score_mat_forw.TF_name="N/A";
	}

	// check for the cutoff specified in case of PSSM --optional
	else if(score_mat_forw.matrix_params.count("cutoff") > 0){ //check if this key exist
		score_mat_forw.score_cutoff=atof(score_mat_forw.matrix_params["cutoff"].c_str());
	}

	else if(score_mat_forw.matrix_params.count("type_I_cutoff") > 0){
		score_mat_forw.score_cutoff_I=atof(score_mat_forw.matrix_params["type_I_cutoff"].c_str());
		CUTOFF_FILE = true;
	}

	else if(score_mat_forw.matrix_params.count("balanced_cutoff") > 0){
		score_mat_forw.score_cutoff_balanced=atof(score_mat_forw.matrix_params["balanced_cutoff"].c_str());
		CUTOFF_FILE = true;
	}

	else if(score_mat_forw.matrix_params.count("type_II_cutoff") > 0){
		score_mat_forw.score_cutoff_II=atof(score_mat_forw.matrix_params["type_II_cutoff"].c_str());
		CUTOFF_FILE = true;
	}

	//G+C content
	else if(score_mat_forw.matrix_params.count("gc") > 0){
		score_mat_forw.gc=atof(score_mat_forw.matrix_params["gc"].c_str());
		GC_FILE = true;
	}

	//lambda
	else if(score_mat_forw.matrix_params.count("lambda") > 0){
		score_mat_forw.lambda=atof(score_mat_forw.matrix_params["lambda"].c_str());
		LAMBDA_FILE = true;
	}

	//lnR0
	else if(score_mat_forw.matrix_params.count("lnR0") > 0){
		score_mat_forw.lnR0=atof(score_mat_forw.matrix_params["lnR0"].c_str());
		LNR0_FILE = true;
	}
}

///////////////-----------------------------------------------------/////////////////////////
//modify matrix attributes, depending on user-specific values
void adapt_matrix_params(){

	//lambda value
	if (!LAMBDA_FILE) {
		score_mat_forw.lambda = fact_lambda;
	}
	// lnR0
	if (!LNR0_FILE && FACT_LNR0){
		score_mat_forw.lnR0 = fact_lnR0;
	}
	// cutoff
	if (EXTN_THRESH){
		score_mat_forw.score_cutoff = score_thresh;
	}
	// gc (user-provided option overrides file option)
	if (EXTN_GC_FLAG){
			score_mat_forw.gc = gc_content;
		}
	if (!GC_FILE && !EXTN_GC_FLAG){ GC_RANGE = true;}
}

///////////////-----------------------------------------------------/////////////////////////
// put the matrix in the vector of matrices
void store_matrix(){
	//set length
	score_mat_forw.set_motif_length(motif_length);
	score_mat_back.set_motif_length(motif_length);

	//set strand
	if (score_mat_forw.matrix_params.count("strand") > 0){
		if (!score_mat_forw.matrix_params["strand"].compare("+")) {
			score_mat_forw.strand='+';
			score_mat_back.strand='-';
		} else {
			score_mat_forw.strand='-';
			score_mat_back.strand='+';
		}
	} else {
		score_mat_forw.strand='+';
		score_mat_back.strand='-';
	}
	motif_matrices.push_back(score_mat_forw);	 // pushing the +ve strand matrix in to the list
	reverse(score_mat_back.weight.begin(),score_mat_back.weight.end());
	reverse(score_mat_back.consensus.begin(),score_mat_back.consensus.end());
	reverse(score_mat_back.mult_consensus.begin(),score_mat_back.mult_consensus.end());
	motif_matrices.push_back(score_mat_back);  	// pushing the -ve strand matrix into the list
}

///////////////-----------------------------------------------------/////////////////////////
bool IsElement (string TF_name, vector<string> name_flags ) {

  if (!NAME_FLAG) return true;
  for (unsigned int i=0; i<name_flags.size(); i++) {
    if( strstr(TF_name.c_str(),name_flags[i].c_str())!=NULL) return true;
  }

  return false;
}


