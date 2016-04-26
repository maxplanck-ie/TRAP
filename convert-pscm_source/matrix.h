#ifndef MATRIX_H_
#define MATRIX_H_

#ifndef VECTOR_H_
#include<vector>
#endif

#ifndef MAP_H_
#include<map>
#endif

#ifndef STRING_H_
#include<string>
#endif

#define MAX_NAME_LENGTH		100
#define MAX_LINE_LENGTH		512
#define MATRIX_LENGTH		50

using std::string;
using std::vector;
using std::map;

//===================== Personnalised Class ========================//
class motifMatrix {

 public:
  string type;
  string id;
  string TF_name;
  map <string,string> matrix_params;
  map<string,string>::iterator params_iter;
  vector<vector <double> > weight;
  vector<int> consensus;
  vector<int> mult_consensus;
  vector<double> min_val_array;
  
  int motif_length;
  int total_exp;
  string strand;
  double gc;
  double score_cutoff;
  double score_cutoff_I;
  double score_cutoff_II;
  double score_cutoff_balanced;
  double lambda;
  double lnR0;
  double mask_value;
  double min_value;
   
 public:
  motifMatrix (){};
  motifMatrix (const motifMatrix *p) {};
  
  void set_motif_length(int mat_length){motif_length=mat_length;}
  int  get_motif_length(){return motif_length;}
  void clear_matrix_values (){
	  type.clear();
	  id.clear();
	  TF_name.clear();
	  matrix_params.clear();
	  weight.clear();
	  consensus.clear();
	  mult_consensus.clear();
	  min_val_array.clear();
	  motif_length = 0;
	  total_exp = 0;
	  gc = 0;
	  score_cutoff= 0;
	  score_cutoff_I= 0;
	  score_cutoff_II= 0;
	  score_cutoff_balanced= 0;
	  lambda= 0;
	  lnR0= 0;
  }
  
};
//==================================================================//

// declarations of functions
void read_matrix_file(char *);
void pscms_to_pspms();
void pscm_to_psem(const double&);
void pscms_to_psems();
void pspm_to_pssm(const double&);
void pspms_to_pssms();
void print_all_matrices();
void analyze_matrix_properties();
motifMatrix analyze_individual_matrices_annotate_fast(motifMatrix & matrix);
void getConsensus(const vector<double>& row);

//external variables
extern map <string,bool> matrices_identities_map;
extern vector <double> GC_vector;
extern vector <class motifMatrix> motif_matrices;
extern vector <class motifMatrix> pssm_motif_matrices;
extern vector <class motifMatrix> psem_motif_matrices;

extern vector<double> temp_score;
extern double pscount;
extern double score_thresh;
extern double fact_lambda;
extern double fact_lnR0;
extern double gc_content;

extern vector<string> name_flags;

extern bool EXTN_GC_FLAG;
extern bool GC_RANGE;
extern bool GC_FILE;
extern bool NAME_FLAG;
extern bool PSCM;
extern bool PSSM;
extern bool PSEM;
extern bool EXTN_THRESH;
extern bool FACT_LAMBDA;
extern bool FACT_LNR0;
extern bool PRINT_BOTH;
extern int list_size;
extern string thresh_type;
extern vector<string> score_print;
#endif /*MATRIX_H_*/
