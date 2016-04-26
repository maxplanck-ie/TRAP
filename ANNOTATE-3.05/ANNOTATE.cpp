#include <iostream>
#include<fstream>
#include <string>
#include"matrix.h"
#include"annotate_sequence.h"
#include"score_calc.h"
#include<time.h>
#include<cmath>
#include <cstdlib>
#include "string.h"
#include <algorithm>

using namespace std;

//function declarations for this class
void read_command_line_options(int,char**);
void print_usage();
void print_help();
void validate_options();
void initialize_Sequenceinput_GFFoutput(int,char**);

//variables
char gap_char;
double gc_content;		   //external gc_content variable
double score_thresh=0;		   //score cutoff hardwired default value '0'
double pscount=1;		   //pseudo count hard wired to 1
string thresh_type="balanced";		   //for the 3-types cutoff, default is balanced
double fact_lambda=0.7;		  //lambda in affinity based annotation hardwired to '0.7'
double fact_lnR0;												
long region_size;
int number_of_top_scores;
string mask_handle = "average";
string single_strand_direct;
vector<double> GC_vector;
vector<class motifMatrix> pssm_motif_matrices;
vector<class motifMatrix> psem_motif_matrices;

//vector that contains positions of the motif to discard
vector<int> discard_pos;
string discard_pos_param;

// flags serving different purposes
bool GAP=false;
bool DEF_GC=false;
bool GC_RANGE = false;
bool NAME_FLAG=false;
bool ANNOTATION_AVERAGE=false;
bool MASK_SCORING=true;
bool DISCARD_POS=false;
bool SINGLE_STRAND = false;
bool SS_FORWARD = true;
bool AFFINITY_SCORE=false;
bool EXTN_GC_FLAG=false;
bool LARGEST=false;
bool PSSM=false;
bool PSCM=false;
bool PSEM=false;
bool EXIT=false;
bool USER_SHIFT=false;
bool EXTN_SEQ_FILE=false;
bool EXTN_GFF_FILE=false;
bool FACT_LAMBDA=false;
bool FACT_LNR0=false;
bool EXTN_THRESH=false;
bool THRESH_TYPE = false;
bool DEBUG=false;
bool REGION=false;
bool TABLE=false;
int region_shift=0;

const char *matFile;
const char *seqFile;
const char *op_file;

char *ps_count,*regSize,*regShift,*nTopScore;
vector<string> name_flags;
istream *user_seq_file;		  //stream object for input of sequence
ostream *user_gff_file;		  //stream object for output of gff

int main(int argc,char *argv[]){

//	string s;
//
//	while(cin) {
//		getline(cin,s);
//		   cout << "line read" << s << endl;
//	  };
//	exit(0);

  // loop over all the command line arguments entered
  read_command_line_options(argc,argv);
 
  // checking for wrong inputs during entry of parameters in the begining
  validate_options();
  
  // initialize the input of sequence file and output of gff file
  initialize_Sequenceinput_GFFoutput(argc,argv);
  
  // reading the matrix file.. and storing all the matrices in motif_matrices list
   read_matrix_file(matFile); //see matrix.h and read_matrix.cpp files

   // if affinity based scoring
  if(AFFINITY_SCORE){
	analyze_matrix_properties();
	if (MASK_SCORING) matrices_mask_scoring();
	// start the routine for reading sequences and score calculation
    calc_affinities();
    
  } else{

    analyze_matrix_properties();
    // call the routine for reading sequences and score calculation
    calc_hits();
  }
  
  motif_matrices.clear();  
  pssm_motif_matrices.clear();  
  psem_motif_matrices.clear();  
  
  return 0;
}

///////////////-----------------------------------------------------/////////////////////////

void read_command_line_options(int argc,char **argv){
	
 matFile="";
 seqFile="";
 op_file="";

 // if no options: print help manual and exit
 if(argc < 2){
	print_usage();
	exit(1);
 }
 //loop through all the command line arguments(options)
 for(int i=1;i<argc;i++){

   if(argv[i][0] == '-'){

     if(argv[i][1]=='s'){
       seqFile=argv[++i];
       EXTN_SEQ_FILE=true;}

     else if(argv[i][1]=='o'){
       op_file=argv[++i];
       EXTN_GFF_FILE=true;}
     
     else if(argv[i][1]=='R'){	
       REGION=true;
       regSize=argv[++i];
       region_size=atoi(regSize);}
		
     else if(argv[i][1]=='t'){
       score_thresh=atof(argv[++i]);
       EXTN_THRESH=true;}

     else if(strstr(argv[i],"-ttype")){
       thresh_type=argv[++i];
       THRESH_TYPE=true;}
		
     else if(argv[i][1]=='g'){
       gc_content=atof(argv[++i]);
       DEF_GC=true;
       EXTN_GC_FLAG=true;}
     
     else if(argv[i][1]=='a'){
       AFFINITY_SCORE=true;}
     
     else if(argv[i][1]=='d'){
       DEBUG=true;}
	
     else if(argv[i][1]=='l'){
       LARGEST=true;
       nTopScore=argv[++i];
       number_of_top_scores=atoi(nTopScore);}
   
     else if(argv[i][1]=='S'){
       regShift=argv[++i];
       region_shift=atoi(regShift);
       USER_SHIFT=true;}
     
     else if(strstr(argv[i],"-lambda")){
       fact_lambda=atof(argv[++i]);
       FACT_LAMBDA=true;}
     
     else if(strstr(argv[i],"-lnR0")){
       fact_lnR0=atof(argv[++i]);
       FACT_LNR0=true;}
     
     else if(strstr(argv[i],"-pssm")){
       PSSM=true;
       matFile = argv[++i];}
     
     else if(strstr(argv[i],"-psem")){
       PSEM=true;
       AFFINITY_SCORE=true;
       matFile = argv[++i];}
     
     else if(strstr(argv[i],"-mscore")){
       mask_handle = argv[++i];}

     else if(strstr(argv[i],"-discard")){
    	DISCARD_POS = true;
    	discard_pos_param = argv[++i];}

     else if(strstr(argv[i],"-tab")){
       TABLE=true;}

     else if(strstr(argv[i],"-strand")){
    	SINGLE_STRAND = true;
    	single_strand_direct = argv[++i];}

     else if(strstr(argv[i],"-name")){
       NAME_FLAG=true;
       char *name_fl = argv[++i];
       char *names   = strtok(name_fl," ,");

       while(names!=NULL){
	 //cout << "name_flag = " << names << endl;
	 name_flags.push_back(names);
	 names=strtok(NULL," ,");

	 //strcpy(&name_flags[i++][0],names);
       }
      
       //exit(0);
     }
     
     else if(strstr(argv[i],"-gap")){
    	 GAP=true;
    	 if(strlen(argv[i+1])!=1)
    		 cerr<<"ERROR: cannot have gap character length more than  1"<<endl;
    	 gap_char=argv[++i][0];
     }

     else if(argv[i][1]=='h' || strstr(argv[i],"-h") || strstr(argv[i],"-help")){
    	 print_help();
     }
     else {
  	   print_help();
     }
   }
 }
}

///////////////-----------------------------------------------------/////////////////////////
//routine to print the help of the program
void print_usage(){
	cerr<<"[use -h or --help options to get the full manual]"<<endl;
	cerr<<""<<endl;
	cerr<<"**** Warning: use the program convert-pscm before this program to correctly format your matrices ***"<<endl;
	cerr<<""<<endl;
	cerr<<"	ANNOTATE -s <sequence-filename>"<<endl;
	cerr<<""<<endl;
	cerr<<"======> options for hits (weight scores) calculation"<<endl;
	cerr<<"	--pssm <matrix-filename>"<<endl;
	cerr<<"	-t <threshold>		set a threshold for the score"<<endl;
	cerr<<"	--ttype <typeI, typeII, balanced>	type of cutoff to use from the matrix file"<<endl;
	cerr<<"	-d	        	print the sequence for binding site along with the score"<<endl;
	cerr<<"======> options for affinity calculation"<<endl;
	cerr<<"	--psem <matrix-filename>"<<endl;
	cerr<<"	--lambda [NUM]		lambda parameter for AFFINITY based annotation(default is 0.7)"<<endl;
	cerr<<"	--lnR0 [NUM]		logR0 parameter for AFFINITY based annotation(default is 0.584*w-5.66"<<endl;
	cerr<<"				w is the length of TF and lambda is 0.7)"<<endl;
	cerr<<"	--mscore <skip, worse, average>		handling of masked regions. (default is average)"<<endl;
	cerr<<"	--tab			output is a table instead of GFF file (this output can serve as input for PASTAA)"<<endl;
	cerr<<"	--strand		perform calculation on a single strand (accepted values: F (forward) or R (reverse). Default is to perform with double strand."<<endl;
	cerr<<"	--discard <motif position(s)>		specify positions in the motif to discard, ie that will not contribute to the affinity. Separate values with comma (eg. 7,8,9)"<<endl;
	cerr<<"======> options for both ###"<<endl;
	cerr<<"	-o <output-file>	output the result in a file (default is STDOUT)"<<endl;
	cerr<<"	-g <gc-content>		set the GC content to be used for all regions.(override the local gc values)"<<endl;
	cerr<<"	-R [REGION_SIZE]	region size for local results"<<endl;
	cerr<<"	-S [REGION-SHIFT]	lengths of shift of region over the sequence (not the overlap)"<<endl;
	cerr<<"	-l [rank l]       	print the l largest scores in the whole sequence"<<endl;
	cerr<<"	-name <matrix_name>		specify a matrix name from your matrix list"<<endl;
	cerr<<"	-gap \"char\"		trim the sequence using this character"<<endl;
	cerr<<"[deprecated options]"<<endl;
	cerr<<"	-a 	        	affinity based annotation(default is hit based)"<<endl;
	cerr<<"	now automatically finds from -pssm and -psem"<<endl;

}

void print_help(){
	cerr<<"NAME"<<endl;
	cerr<<"	TRAP (TRanscription factor Affinity Prediction)"<<endl;
	cerr<<""<<endl;
	cerr<<"DESCRIPTION"<<endl;
	cerr<<"	Scan sequences with binding motifs represented as matrices, to find putative regulatory regions."<<endl;
	cerr<<"	TRAP can either returns binding affinities or hits (weights scoring) ."<<endl;
	cerr<<""<<endl;
	cerr<<"AUTHORS"<<endl;
	cerr<<"	Helger Roider"<<endl;
	cerr<<"	Thomas Manke"<<endl;
	cerr<<"	Refactoring of the code by Morgane Thomas-Chollier"<<endl;
	cerr<<""<<endl;
	cerr<<"PUBLICATIONS"<<endl;
	cerr<<"	Roider et al. Predicting transcription factor affinities to DNA from a biophysical model. Bioinformatics (2007) vol. 23 (2) pp. 134-41"<<endl;
	cerr<<"	Manke et al. Statistical modeling of transcription factor binding affinities predicts regulatory interactions. PLoS Comput Biol (2008) vol. 4 (3)"<<endl;
	cerr<<""<<endl;
	cerr<<"USAGE"<<endl;
	print_usage();
	cerr<<""<<endl;
	cerr<<"INPUT FORMATS"<<endl;
	cerr<<"	-	Matrices: fasta-like format (similar to cluster-buster program)"<<endl;
	cerr<<"	The four columns correspond to the four nucleotides A,C,G,T"<<endl;
	cerr<<""<<endl;
	cerr<<"	Example:"<<endl;
	cerr<<"	>M00001	/name='V$MYOD_01' "<<endl;
	cerr<<"	1	2	2	0"<<endl;
	cerr<<"	2	1	2	0"<<endl;
	cerr<<"	3	0	1	1"<<endl;
	cerr<<"	Refer to the manual of convert-pscm for additional info on matrices (type convert-pscm -h)"<<endl;
	cerr<<"	Matrices are automatically reversed to search both strands"<<endl;
	cerr<<"	No other manipulations are applied to the matrices. Use convert-pscm (or other programs) "<<endl;
	cerr<<"	to apply pseudocounts or change the G+C content"<<endl;
	cerr<<"	-	Sequences: fasta format"<<endl;
	cerr<<""<<endl;
	cerr<<"SCANNING"<<endl;
	cerr<<"	-	PSSM: scoring matrix => hit-based scanning. Only hits reaching the threshold are returned Default threshold=0."<<endl;
	cerr<<"	For each position aligned with the matrix, a score is calculated, and returned if it reaches a given threshold. This position is then considered as a hit."<<endl;
	cerr<<"	Note that the -R option is slightly different in this context: it enables the calculation with a varying G+C, calculated in the local region. Provide a list of matrices with different G+C contents. Indicate a large region value, so that the G+C content is calculated on a sufficient dataset. "<<endl;
	cerr<<"	-	PSEM: mismatch energy matrix"<<endl;
	cerr<<"	For each position aligned with the matrix, an affinity is calculated, and then summed over the length of the studied region."<<endl;
	cerr<<"	The longer the region, the higher the affinity (as it is a sum)."<<endl;
	cerr<<"	To get more local results, use the region option (-R). If a G+C value is provided (eg 0.5), this value is used for all scored regions. To calculate with a varying G+C, provide a list of matrices with different G+C contents. In this case, provide a large region value, so that the G+C content is calculated on a sufficient dataset. "<<endl;
	cerr<<""<<endl;
	cerr<<""<<endl;
	cerr<<"OUTPUT FORMATS"<<endl;
	cerr<<"	GFF file"<<endl;
	exit(1);
}

///////////////-----------------------------------------------------/////////////////////////
//routine to check for the validity of the options of the tool
void validate_options(){

	if(!EXTN_SEQ_FILE){
		cerr<<"ERROR: Provide a sequence to scan with the -s option"<<endl;
		EXIT=true;
	}
	if(PSSM && AFFINITY_SCORE ){
		cerr<<"ERROR: Score matrix not applicable with affinity based annotation"<<endl;
		EXIT=true;
	}
	if(USER_SHIFT && !AFFINITY_SCORE){
		cerr<<"ERROR: Shift operation not possible while using traditional annotation"<<endl;
		EXIT=true;
	}
	if(FACT_LAMBDA && !AFFINITY_SCORE){
		cerr<<"ERROR: LAMBDA paramater cannot be used with traditional score annotaition"<<endl;
		EXIT=true;
	}
	if(FACT_LNR0 && !AFFINITY_SCORE){
		cerr<<"ERROR: LNR0 parameter cannot be used with trtadtional score annotation"<<endl;
		EXIT=true;
	}
	if(EXTN_GC_FLAG && REGION && !AFFINITY_SCORE){
		cerr<<"ERROR: Cannot specify GC global externally and local GC for regions at the same time"<<endl;
		EXIT=true;
	}

	if (MASK_SCORING) {
		if (!mask_handle.compare("skip")){
			MASK_SCORING = false;
		} else if (!mask_handle.compare("worse")){
			ANNOTATION_AVERAGE = false;
		} else if (!mask_handle.compare("average")){
			ANNOTATION_AVERAGE = true;
		} else {
			cerr<<"ERROR: the value "<<mask_handle<<" is not recognized for the option --mscore."<<endl;
			EXIT=true;
		}
	}

	if (DISCARD_POS) {

		int pos_value = 0;
		int unsigned next;

		while( (next= discard_pos_param.find_first_of(',')) != discard_pos_param.npos ) {
			if (next> 0)
				pos_value = atoi(discard_pos_param.substr(0,next).c_str());
			if (pos_value == 0) {
				cerr<<"ERROR: The position to discard is not specified correctly"<<endl;
				EXIT=true;
			}
			discard_pos.push_back(pos_value-1); //-1 because the internal motif position number starts at 0
			discard_pos_param = discard_pos_param.substr(next+1);
		}
		if(discard_pos_param.length() > 0)
			pos_value = atoi(discard_pos_param.substr(0,next).c_str());
		if (pos_value == 0) {
			cerr<<"ERROR: The position to discard is not specified correctly"<<endl;
			EXIT=true;
		}
		discard_pos.push_back(pos_value-1); //-1 because the internal motif position number starts at 0
	}

	if (SINGLE_STRAND){
		if (!AFFINITY_SCORE){
				cerr<<"ERROR: the --strand option is only compatible with affinity calculation"<<endl;
				EXIT=true;
			} else {
					if (!single_strand_direct.compare("F")){
							SS_FORWARD = true;
					} else if (!single_strand_direct.compare("R")){
							SS_FORWARD = false;
					} else {
						cerr<<"ERROR: the value "<< single_strand_direct <<" is not recognized for the option --strand (can only be F or R)."<<endl;
						EXIT=true;
					}
			}
	}


	/* if(abs(atof(regSize))!=atof(regSize)){
     cerr<<"ERROR: Region size can only take real values"<<endl;
     }
     if(abs(atof(regShift))!=atof(regShift)){
     cerr<<"ERROR: Region Shift can only take real values"<<endl;
     }*/
	if(EXIT){
		//error print
		cerr<<"Invalid options. Check manual for proper usage with -h option."<<endl;
		exit(1);
	}
}
///////////////-----------------------------------------------------/////////////////////////
void initialize_Sequenceinput_GFFoutput(int argc,char **argv){
  
  user_seq_file=&cin;  // initializing the stream object for reading sequences with STANDARD INPUT;
  if(EXTN_SEQ_FILE){  // if external paramater -s is specified... override the stream object with 
    
    user_seq_file=new ifstream(seqFile);   // the file for the input file specified by the user
    
    // check if the file exists
    if(user_seq_file->fail()){		    
      cerr<<"ERROR: SEQUENCE FILE NOT FOUND"<<endl;
      exit(1);
    }	 	
    
  }
  
  user_gff_file=&cout;	    // initializing the stream object for gff output as STANDARD OUTPUT
  if(EXTN_GFF_FILE)	    // if external paramater is specified... override the stream object with 
    user_gff_file=new ofstream(op_file);	     // the file for the output file specified by the user
  
  //start the output file with the command used
  *user_gff_file <<"#command_line= ";
  for (int la=0; la<argc; la++) *user_gff_file << argv[la] << " "; *user_gff_file<<endl;

  //headers for the columns of the output
  if (!TABLE){
	  *user_gff_file <<"#seqname\tsource\tfeature\tstart\tend\tscore\tstrand\tframe\tattributes"; ; *user_gff_file<<endl;
  }
}


