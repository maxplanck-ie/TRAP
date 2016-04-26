#include <iostream>
#include<fstream>
#include <string>
#include"matrix.h"
#include<time.h>
#include<cmath>
#include <algorithm>
#include <cstdlib>
#include "string.h"

using namespace std;

//function declarations for this class
void read_command_line_options(int,char**);
void print_usage();
void print_help();
void validate_options();
void initialize_output();
void GC_content_process();
void pscm_convert();


//variables
char gap_char;
double gc_content;		   //external gc_content variable
double pscount=1;		   //pseudo count hard wired to 1
string outformat = "pssm"; //default output format is pssm
double fact_lambda=0.7;		  //lambda in affinity based annotation hardwired to '0.7'
double fact_lnR0;
double score_thresh;

vector<double> GC_vector;

// flags serving different purposes
bool NAME_FLAG=false;
bool EXTN_GC_FLAG=false;
bool GC_RANGE = false;
bool LARGEST=false;
bool PSSM=false;
bool PSCM=false;
bool PSEM=false;
bool EXIT=false;
bool EXTN_OUTFILE=false;
bool DEBUG=false;
bool PSEUDO_COUNT=false;
bool FACT_LAMBDA=false;
bool FACT_LNR0=false;
bool EXTN_THRESH=false;
bool PRINT_BOTH = false;


char *matFile,*ps_count,*out_filename;
vector<string> name_flags;
ostream *user_out_file;		  //stream object for output file


///////////////------------MAIN PROGRAM------------------/////////////////////////

int main(int argc,char *argv[]){

  // loop over all the command line arguments entered
  read_command_line_options(argc,argv);

  // checking for wrong inputs during entry of parameters in the beginning
  validate_options();

  // output file
  initialize_output();

  // reading the matrix file.. and storing all the matrices in motif_matrices list
  read_matrix_file(matFile); //see matrix.h and read_matrix.cpp files

  // handle G+C content to use for conversion. If necessary, generate vector of different gc values
  GC_content_process();

  // perform the conversion
  pscm_convert();

  //output
  print_all_matrices();
  
  // free memory
  motif_matrices.clear();  
  pssm_motif_matrices.clear();  
  psem_motif_matrices.clear();  
  
  return 0;
}

///////////////---------------SUBROUTINES--------------------------------------/////////////////////////

void read_command_line_options(int argc,char **argv){
	
 matFile="";
 out_filename="";


 // if no options: print help manual and exit
 if(argc < 2){
	print_usage();
	exit(1);
 }
 //loop through all the command line arguments(options)
 for(int i=1;i<argc;i++){

   if(argv[i][0] == '-'){

     if(argv[i][1]=='o'){
       out_filename=argv[++i];
       EXTN_OUTFILE=true;}
		
     else if(argv[i][1]=='g'){
       gc_content=atof(argv[++i]);
       EXTN_GC_FLAG=true;
		}
	
     else if(argv[i][1]=='p'){
       PSEUDO_COUNT=true;
       ps_count=argv[++i];
       pscount=atof(ps_count);}

     else if(strstr(argv[i],"-range")){
       GC_RANGE=true;}

     else if(argv[i][1]=='b'){
       PRINT_BOTH=true;}

     else if(strstr(argv[i],"-to")){
       outformat=argv[++i];
       }

     else if(argv[i][1]=='t'){
       score_thresh=atof(argv[++i]);
       EXTN_THRESH=true;}

     else if(strstr(argv[i],"-lambda")){
       fact_lambda=atof(argv[++i]);
       FACT_LAMBDA=true;}

     else if(strstr(argv[i],"-lnR0")){
       fact_lnR0=atof(argv[++i]);
       FACT_LNR0=true;}

     else if(strstr(argv[i],"-pscm")){
       PSCM=true;
       matFile = argv[++i];}

     // future options
    // else if(strstr(argv[i],"-ambig")){}
    // else if(strstr(argv[i],"-trim")){}


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
	cerr<<"	convert-pscm  "<<endl;
	cerr<<""<<endl;
	cerr<<"	--pscm <matrix-filename>"<<endl;
	cerr<<"	--to <pspm,pssm,psem>	output format (default is pssm)"<<endl;
	cerr<<"	-g <gc-content>		set a single GC content value"<<endl;
	cerr<<"	--range			outputs multiple matrices spanning a wide range of GC content (default) "<<endl;
	cerr<<"	-p <pseudocount> 	pseudocount (default is 1)"<<endl;
	cerr<<"	-o <output-file>	output the result in a file (default is STDOUT)"<<endl;
	cerr<<"	-b 			output both forward and reverse matrices (default is only forward)"<<endl;
	cerr<<"======> options for pssm output"<<endl;
	cerr<<"	-t <threshold>		defines a cutoff value"<<endl;
	cerr<<"======> options for psem ouput"<<endl;
	cerr<<"	--lambda [NUM]		lambda parameter for AFFINITY based annotation(default is 0.7)"<<endl;
	cerr<<"	--lnR0 [NUM]		logR0 parameter for AFFINITY based annotation(default is 0.584*w-5.66"<<endl;
	cerr<<"						w is the length of TF and lambda is 0.7)"<<endl;
	cerr<<""<<endl;
}

void print_help(){
	cerr<<"NAME"<<endl;
	cerr<<"	convert-pscm"<<endl;
	cerr<<""<<endl;
	cerr<<"DESCRIPTION"<<endl;
	cerr<<"	Converts a pscm into pssm or psem."<<endl;
	cerr<<"	One or more matrices can be returned, depending on the GC content."<<endl;
	cerr<<""<<endl;
	cerr<<"AUTHORS"<<endl;
	cerr<<"	Thomas-Chollier Morgane"<<endl;
	cerr<<"	Based on code from Helge Roider and Thomas Manke"<<endl;
	cerr<<""<<endl;
	cerr<<"USAGE"<<endl;
	print_usage();
	cerr<<""<<endl;
	cerr<<"INPUT FORMAT"<<endl;
	cerr<<"	Matrices: fasta-like format (similar to cluster-buster program)"<<endl;
	cerr<<"	Some standard parameters are automatically recognized:"<<endl;
	cerr<<"	/name=		name of the matrix"<<endl;
	cerr<<"	/type=		type of matrix (pscm,pssm,psem)"<<endl;
	cerr<<"	/strand=	strand of the matrix"<<endl;
	cerr<<"	/size=		size of the motif"<<endl;
	cerr<<"	/gc_content=	G+C content of the matrix"<<endl;
	cerr<<"	/gc=		G+C values used for converting pscm to psem or pssm"<<endl;
	cerr<<"	Warning: do not mix the /gc and /gc_content values !"<<endl;
	cerr<<""<<endl;
	cerr<<"	The four columns correspond to the four nucleotides A,C,G,T"<<endl;
	cerr<<""<<endl;
	cerr<<"	Example:"<<endl;
	cerr<<"	>M00001	/name='V$MYOD_01' "<<endl;
	cerr<<"	1	2	2	0"<<endl;
	cerr<<"	2	1	2	0"<<endl;
	cerr<<"	3	0	1	1"<<endl;
	cerr<<""<<endl;
	cerr<<"CONVERSION"<<endl;
	cerr<<"	pscm is automatically converted into pssm (hit_based) or psem (affinity)"<<endl;
	cerr<<"	using the pseudocount and the G+C content (for pssm: this corresponds to a Bernoulli background model)"<<endl;
	cerr<<"	To obtain a single matrix as outpout, the user must provide a value for the G+C content"<<endl;
	cerr<<"	with the -g option (value between 0 and 1)."<<endl;
	cerr<<"	If The G+C content is not provided by the user, or by using explicitely the --range option,"<<endl;
	cerr<<"	a range of G+C content from 0.01 to 0.99 is taken."<<endl;
	cerr<<"	The program returns one matrix for each G+C content."<<endl;
	cerr<<""<<endl;
	cerr<<"DIFFERENT TYPES OF MATRICES"<<endl;
	cerr<<"	PSCM: 	count matrix"<<endl;
	cerr<<"		Each cell of the matrix contains the number of each nucleotide A,C,G,T"<<endl;
	cerr<<"		for each position of the motif described by this matrix."<<endl;
	cerr<<"	PSPM: 	probability matrix, also known as PFM (frequency matrix)"<<endl;
	cerr<<"		Each cell of the matrix contains the frequency of each nucleotide A,C,G,T"<<endl;
	cerr<<"		for each position of the motif described by this matrix."<<endl;
	cerr<<"	PSSM: 	scoring matrix"<<endl;
	cerr<<"		Each cell of the matrix contains a weight that already takes into account"<<endl;
	cerr<<"		the background model (Bernoulli, G+C content)"<<endl;
	cerr<<"		Such matrices are used for the hit_based scanning of the sequence "<<endl;
	cerr<<"		A threshold can be assigned to the matrix with -t options. "<<endl;
	cerr<<"		This threshold is then included in the header of the matrix,"<<endl;
	cerr<<"	 	and will thus be applied by default when using this matrix."<<endl;
	cerr<<"		Example: "<<endl;
	cerr<<"		>M00001	/cutoff='5.2' /name='V$MYOD_01' "<<endl;
	cerr<<"	PSEM: mismatch energy matrix"<<endl;
	cerr<<"		Each cell of the matrix contains the mismatch energy of each nucleotide, "<<endl;
	cerr<<"		at each position (see publications for more info). "<<endl;
	cerr<<"		Both the pseudocount and the gc_content are used to convert the pscm into a psem. "<<endl;
	cerr<<"		The lambda factor is also used for the conversion. "<<endl;
	cerr<<""<<endl;
	cerr<<"WARNINGS"<<endl;
	cerr<<"	The default pseudo-count of 1 is quite high, should be set to lower values (eg 0.25) for matrices based on few observations."<<endl;
	cerr<<"	Conversion to PSSM is simple and does not include the regularizations proposed in (Rahmann S, 2003)."<<endl;
	cerr<<"PUBLICATIONS"<<endl;
	cerr<<"	Roider et al. Predicting transcription factor affinities to DNA from a biophysical model. Bioinformatics (2007) vol. 23 (2) pp. 134-41"<<endl;
	cerr<<"	Manke et al. Statistical modeling of transcription factor binding affinities predicts regulatory interactions. PLoS Comput Biol (2008) vol. 4 (3)"<<endl;
	cerr<<""<<endl;

	cerr<<""<<endl;
	exit(1);
}

///////////////-----------------------------------------------------/////////////////////////
void initialize_output(){

  user_out_file=&cout;	    // initializing the stream object for output as STANDARD OUTPUT
  if(EXTN_OUTFILE)	    // if external paramater is specified... override the stream object with
	  user_out_file=new ofstream(out_filename);	     // the file for the output file specified by the user

}

///////////////-----------------------------------------------------/////////////////////////
//routine to check for the validity of the options of the tool
void validate_options(){

	if(!PSCM){
		cerr<<"ERROR: Provide a matrix file with the option --pscm"<<endl;
		EXIT=true;
	}
	if(GC_RANGE && EXTN_GC_FLAG){
			cerr<<"ERROR: -g and -g_range options are incompatible."<<endl;
			EXIT=true;
		}
	if(EXIT){
		//error print
		cerr<<"Invalid options. Check manual for proper usage with -h option."<<endl;
		exit(1);
	}
}

///////////////-----------------------------------------------------/////////////////////////
void GC_content_process(){

	if (GC_RANGE) {
	 //generate GC's for converting pscm to pssm

    GC_vector.push_back(0.01);  // use approximate instead of gc=0

    // starting from gc=0.05 with an increment of 0.05 at every step
    gc_content=0.05;	  // push all the generated gc's into the vector list
    while(gc_content<=1){
      GC_vector.push_back(gc_content);
      gc_content+=0.05;
    }

    GC_vector.push_back(0.99);  // use approximate instead of gc=1

  }
}

///////////////-----------------------------------------------------/////////////////////////
void pscm_convert(){

	// if affinity based psem

	if(outformat.compare("psem") == 0){ // compare returns 0 if s==s1
	    // calculating the various properties of matrices... ie minimum and maximum values in each row
	    analyze_matrix_properties();
	    pscms_to_psems();


	   }else if(!outformat.compare("pssm") || !outformat.compare("pspm")){
		   // calculating the various properties of matrices... ie minimum and maximum values in each row
		  analyze_matrix_properties();
	      pscms_to_pspms(); // PSCM --> PSPM (count matrix to probability matrix

	      if(!outformat.compare("pssm")){ // compare returns 0 if s==s1
	    	  pspms_to_pssms(); // PSPM --> PSSM (prob. matrix to score matrix
	      }
	 } else {
		cerr<<"ERROR: invalid output format "<< outformat<<". Check -to option."<<endl;
		exit(1);
	 }
}
