#include<iostream>
#include<fstream>
#include<cmath>
#include<map>
#include<sstream>
#include"matrix.h"
#include"region_read.h"
#include"score_calc.h"
#include <cstdlib>
#include "string.h"
#include <algorithm>

using std::stringstream;
using std::flush;
using std::cout;
using std::endl;
using std::map;

map <int,char> sequence_int2char_map;

int no;
int offset=0;
int k=0;
int gff_offset=0;
int IDoffset=0;
int motifSize=0;

double regionScore=0;
double lambda,lnR0;
double score_cutoff;

double mismatch_energy_pos;
double mismatch_energy_neg;

string motifStrand;

string ANNOTATE_REGION= "\tANNOTATE\tREGION\t";
string motifID;
string motifName;
string seq_start;
string seq_end;
string region_score;
string ID_offset;
string binding_site_score;

////////////////////////////////////////////////////////////////////////////////////////////////
// took this idea from http://www.codeproject.com/vcpp/stl/functor.asp
class scorecomp : public std::binary_function<int,int,bool>  {

  const vector<double>	&m_scores;
  
public:

   // constructor which takes a reference to a vector of scores
   scorecomp( const vector<double> & scores ) : m_scores(scores) {}

  // comparison operator. this will be called by std::sort with two
  // integers. we'll perform a comparison operation on the inputs and
  // return the result of the comparison.
  bool operator()(int a, int b) const {
    // a typical comparison operator compares the two input parameters.
    // this one uses the two input parameters as indexes into the m_scores vector.
      return (m_scores.at(a) > m_scores.at(b) );
  }
};

////////////////////////////////////////////////////////////////////////////////////////////////
// Calculate the affinity for the given region, with the given matrix
class getMatrixProb {
public:
	motifMatrix pos_StrandMat,neg_StrandMat;    //internal copy of matrices(for +ve and -ve strand)
	//pointer to the reference of the sequence
	double mismatchE_pos,mismatchE_neg;
	double prob;      	                   //pointwise probability
	double p_pos,p_neg,temp;
	bool TO_DISCARD_FW;
	bool TO_DISCARD_RW;


	getMatrixProb(motifMatrix& mat1,motifMatrix& mat2):pos_StrandMat(mat1),neg_StrandMat(mat2){}

	double operator() (const double& x) {	     //Operator overload

		mismatchE_pos=0;
		mismatchE_neg=0;

		// iterate over the motif length
		for (int k=0; k<pos_StrandMat.motif_length;k++){
			//cout << "masking: "<< MASK_SCORING << " value "<<pos_StrandMat.mask_value;
			//cout << " offset: " << offset << " k: "<< k << "  length: " << pos_StrandMat.motif_length<< endl;
			//cout << "sequence: "<< seqobj.sequence[offset+k] << endl;

			// if some positions of the motif must be discarded, they should NOT contribute
			// to the probability, thus, they should have the HIGHEST possible mismatch value
			// Indeed, the values in the matrix are MISMATCH energies.
			// If the nucleotide is a match (bound energy) for a given position, then the mismatch energy has a low value
			// On the contrary, if the nucleotide does not match for a given position, then its mismatch energy is very high.
			TO_DISCARD_FW=false;
			TO_DISCARD_RW=false;
			if (DISCARD_POS){
				// iterate over the positions to discard
				for (unsigned int z=0; z<discard_pos.size(); z++) {
					if (k == discard_pos[z]) {
						TO_DISCARD_FW=true;
					}
					if (k == pos_StrandMat.motif_length - discard_pos[z] -1){
						TO_DISCARD_RW=true;
					}
				}
			}

			//N treatment:
			if(seqobj.sequence[offset+k]==5){
				if (MASK_SCORING) {
					// scoring N
					mismatchE_pos += pos_StrandMat.mask_value;
					mismatchE_neg += neg_StrandMat.mask_value;
				} else {
				// skipping the offset containing N
					offset++;
					return 0;
				}
			} else { // A C G T letters to be scored
				no=seqobj.sequence[offset+k]-1; // get the current letter (-1 for matching the index of the letter in the matrix)

				if (TO_DISCARD_FW){
					//cout << "discarded position fw"<< endl;
					mismatchE_pos +=pos_StrandMat.max_value;
					} else {
						//cout << "mismatch energy (pos): "<< pos_StrandMat.weight[k][no] << endl;
						mismatchE_pos +=pos_StrandMat.weight[k][no];
					}

				if (TO_DISCARD_RW){
					//cout << "discarded position rw"<< endl;
					mismatchE_neg +=neg_StrandMat.max_value;
					} else {
						//cout << "mismatch energy (neg): "<< neg_StrandMat.weight[k][no] << endl;
						mismatchE_neg +=neg_StrandMat.weight[k][no];
					}
			}

			//cout << "mismatchpos: "<< mismatchE_pos << endl;
			//cout << "mismatchneg: "<< mismatchE_neg << endl;
		}
		//cout << "mismatchpos: "<< mismatchE_pos << endl;
		//cout << "mismatchneg: "<< mismatchE_neg << endl;

		//		k=0;
		//		for_each(motif_matrices[0].weight.begin(),motif_matrices[0].weight.end(),calcProb_pos);
		//		for_each(neg_StrandMat.weight.begin(),neg_StrandMat.weight.end(),calcProb);


		//double lnR0 = pos_StrandMat.lnR0;

		temp=exp(lnR0-(mismatchE_pos));
		p_pos=temp/(1+temp);

		temp=exp(lnR0-(mismatchE_neg));
		p_neg=temp/(1+temp);

		 if (SINGLE_STRAND && SS_FORWARD) {
			 prob=p_pos;
		 }
		 if (SINGLE_STRAND && !SS_FORWARD) {
			 prob=p_neg;
		 }
		 if (!SINGLE_STRAND) {
			   prob=p_pos+(1-p_pos)*p_neg;  // palindromic correction
			   //prob=p_pos+p_neg;          // no palindromic correction
			   //prob=p_pos;                  // single strand
		 }
		offset++;

		return prob;
	}
};

////////////////////////////////////////////////////////////////////////////////////////////////


void sumScore(const double prb){ regionScore+=prb; }

////////////////////////////////////////////////////////////////////////////////////////////////

void print_sequence(int sequence_map) {
  *user_gff_file<<sequence_int2char_map[sequence_map];
}

//////////////////////////////////////////////////////////////////////////////////////////////

class getMatrixScore {	
public:
  motifMatrix matrix;	     //internal copy of matrix    
  vector<int> sequence;	     //pointer to the reference of the sequence	
  double score;       	     //pointwise score

  getMatrixScore( vector<int>seq,motifMatrix& mat) { sequence=seq;matrix=mat;}
    
  double operator() (const double& x) {						//Operator overload
    score=0;
    for (int k=0; k<matrix.motif_length; k++){
      //cout << "getMatrixScore k = " << k << " " << score << " " << seqobj.sequence[offset+k]-1 << endl;
      if(seqobj.sequence[offset+k]==5){ // ?
	score=-1000;
	break;
      }
      score += matrix.weight[k][(int)seqobj.sequence[offset+k]-1];
    }
    
    offset++;
    return score;
  }
};


///////////////////////////////////////////////////////////////////////////////

void score_calc_bindSite(){
	

  int scores_length =  seqobj.seq_length-region_overlap;
  if (scores_length<1) {
    cout << "score_calc_bindSite -- ERROR: "<<endl;
    cout << "\tseqobj.seq_length " <<  seqobj.seq_length << " is not larger than region_overlap = " << region_overlap<<endl;
    cout << "\tPick larger region -R or smaller matrices. Exit. " << endl;
    exit(1);
  }
  vector<double> scores(scores_length,0);  	//scores stores for one motif matrix at a time
  
  //cout<<"score_calc_bindSite   " << pssm_motif_matrices.size()<<endl;
  //cout<<"scores length         " << seqobj.seq_length-region_overlap<<endl;
  //cout << "score_calc_bindSite " << seqobj.seq_start <<  endl;
  //cout << "score_calc_bindSite " << seqobj.sequence.size()<<  " ";
  //for (unsigned int i=0; i<seqobj.sequence.size(); i++) cout << seqobj.sequence[i];cout<<endl;

  for (unsigned int j = 0; j<pssm_motif_matrices.size(); j++){ // loop over all matrices
    
    offset=0;
    gff_offset=0;
    
    motifID=pssm_motif_matrices[j].id;			
    motifName=pssm_motif_matrices[j].TF_name;					
    motifSize=pssm_motif_matrices[j].motif_length;
    motifStrand=pssm_motif_matrices[j].strand;
    score_cutoff=pssm_motif_matrices[j].score_cutoff;
    
    transform(scores.begin(),		   //calculating the score for each binding site
	      scores.end(),
	      scores.begin(),										
	      getMatrixScore(seqobj.sequence,pssm_motif_matrices[j]));
    

    for (unsigned int i=0; i<scores.size(); i++) {
      if(scores[i] > score_cutoff){
	*user_gff_file<<seqobj.chrom<<"\tANNOTATE\tTF_binding_site\t"<<(i+seqobj.seq_start)
		      <<"\t"<<(i+seqobj.seq_start+motifSize-1)<<"\t"<<scores[i]<<"\t"<<motifStrand<<"\t.\tmatrix_id="
		      <<motifID<<";matrix_name="<<motifName<<";seq_id="<<seqobj.id<<endl;
      }
    }
    
  }
  
  scores.clear();
}


void score_calc_bindSite_debug(){
  
  int scores_length =  seqobj.seq_length-region_overlap;
  if (scores_length<1) {
    cout << "score_calc_bindSite_debug -- ERROR: "<<endl;
    cout << "\tseqobj.seq_length " <<  seqobj.seq_length << " is not larger than region_overlap = " << region_overlap<<endl;
    cout << "\tPick larger region -R or smaller matrices. Exit. " << endl;
    exit(1);
  }

  vector<double> scores(scores_length,0);    //scores stores for one motif matrix at a time
	
  sequence_int2char_map[1]='A';
  sequence_int2char_map[2]='C';
  sequence_int2char_map[3]='G';
  sequence_int2char_map[4]='T';
  sequence_int2char_map[5]='N';
  
  for (unsigned int j = 0; j<pssm_motif_matrices.size(); j++){ // loop over all matrices
    
    offset=0;
    gff_offset=0;
    
    motifID=pssm_motif_matrices[j].id;		
    motifName=pssm_motif_matrices[j].TF_name;				
    motifSize=pssm_motif_matrices[j].motif_length;
    motifStrand=pssm_motif_matrices[j].strand;
    score_cutoff=pssm_motif_matrices[j].score_cutoff;
    
    //cout << "cutoff" << score_cutoff << endl;

    transform(scores.begin(),	    //calculating the score for each binding site
	      scores.end(),
	      scores.begin(),										
	      getMatrixScore(seqobj.sequence,pssm_motif_matrices[j]));
    
    for (unsigned int i=0; i<scores.size(); i++) {
      //cout << i << " " << scores.size() << " " << region_overlap << " " << scores[i] << endl;
      if(scores[i] > score_cutoff){
	*user_gff_file<<seqobj.chrom<<"\tANNOTATE\tTF_binding_site\t"<<(i+seqobj.seq_start)
		      <<"\t"<<(i+seqobj.seq_start+motifSize-1)<<"\t"<<scores[i]<<"\t"<<motifStrand<<"\t.\tmatrix_id="
		      <<motifID<<";matrix_name="<<motifName<<";seq_id="<<seqobj.id<<";match=";
	for(unsigned int j=i;j<i+motifSize;j++) *user_gff_file<<sequence_int2char_map[seqobj.sequence[j]];
	*user_gff_file<<endl;
      }
      
    }

    
  }
  
  scores.clear();
}

///////////////////////////////////////////////////////////////////////////////////////////
// to be replaced by score_calc_bindSite_top()
void score_calc_bindSite_largest(){
  
  int scores_length =  seqobj.seq_length-region_overlap;
  if (scores_length<1) {
    cout << "score_calc_bindSite_debug -- ERROR: "<<endl;
    cout << "\tseqobj.seq_length " <<  seqobj.seq_length << " is not larger than region_overlap = " << region_overlap<<endl;
    cout << "\tPick larger region -R or smaller matrices. Exit. " << endl;
    exit(1);
  }

  vector<double> scores(scores_length,0);    //scores stores for one motif matrix at a time
  
  for (unsigned int j = 0; j<pssm_motif_matrices.size(); j++){ // loop over all matrices
    
    offset=0;
    gff_offset=0;
    
    motifID=pssm_motif_matrices[j].id;		
    motifName=pssm_motif_matrices[j].TF_name;				
    motifSize=pssm_motif_matrices[j].motif_length;
    motifStrand=pssm_motif_matrices[j].strand;
    score_cutoff=pssm_motif_matrices[j].score_cutoff;
    
    transform(scores.begin(),		//calculating the score for each binding site
	      scores.end(),
	      scores.begin(),										
	      getMatrixScore(seqobj.sequence,pssm_motif_matrices[j]));
    

    /* This does not keep properly track of the actual position

       vector<double>::iterator it = max_element(scores.begin(),scores.end());    
       if(*it>largest_score[j]){
       temp_sequence_start[j]=gff_offset+seqobj.seq_start;
       temp_sequence_end[j]=seqobj.seq_start+motifSize-1;
       largest_score[j]=*it;
       }
    
    */

    for (unsigned int i=0;i<scores.size();i++) {
      if (scores[i] > largest_score[j]) {
	temp_sequence_start[j]= i + seqobj.seq_start;
	temp_sequence_end[j]  = temp_sequence_start[j] + motifSize - 1;
	largest_score[j]=scores[i];
      }
    }

  }
  
  scores.clear();
}

bool greater (const double& d1, const double& d2) { return d1 > d2; }

////////////////////////////////////////////////////////////////////////////////////
void score_calc_bindSite_top(){
  // to replace score_calc_bindSite_largest()

  //cout <<"score_calc_bindSite_top: start" <<endl;
  
  int scores_length =  seqobj.seq_length-region_overlap;
  if (scores_length<1) {
    cout << "score_calc_bindSite_debug -- ERROR: "<<endl;
    cout << "\tseqobj.seq_length " <<  seqobj.seq_length << " is not larger than region_overlap = " << region_overlap<<endl;
    cout << "\tPick larger region -R or smaller matrices. Exit. " << endl;
    exit(1);
  }


  double s_ini = 0.0;                             // score to initialize vector
  vector<double> scores(scores_length,s_ini);     // scores stores for one motif matrix at a time
  unsigned int mmax = pssm_motif_matrices.size(); // total number of matrices (one for each strand)

  int k = top_scores[0].size();                   // keep k top ranking scores and their corresponding starts
  vector<double> tp_new(k,s_ini); 
  vector<long>   ts_new(k,0);       

  // loop over all matrices
  for (unsigned int j = 0; j<mmax; j++){ 
    
    offset=0;                           // will be incremented in getMatrixScore
    transform(scores.begin(),		//calculating the score for each binding site
	      scores.end(),
	      scores.begin(),										
	      getMatrixScore(seqobj.sequence,pssm_motif_matrices[j]));

    // the vector "scores" now contains a score for each position of the current sequence region

    // now decide which of scores[i] fall among top_scores 
    // the latter is a k-dimensional vector (for each matrix) which may already contain
    // some top values based on other regions of the same sequence
    // (it may also contain small preset values)

    // previous vector of top_scores and top_starts
    // these vectors are already sorted, i.e tp[0]>tp[1]>.....  and the corresponding starts ts
    vector<double> tp = top_scores[j];
    vector<long>   ts = top_starts[j];
    
    for (unsigned int i=0;i<scores.size();i++) {

      //cout << i+seqobj.seq_start << " score = " << scores[i] << endl;
      if (scores[i]<= tp[k-1]) continue;   // those scores[i] will never make it into the top

      // cout << "score_calc: add scores[i] = " <<  scores[i] << endl;

      tp[k-1] = scores[i];                // reset the smallest element of tp
      ts[k-1] = i + seqobj.seq_start;     // and the corresponding start ts

      // sort(tp.begin(), tp.end(), greater );
      // this simple sorting of the vector of scores (tp) would not be enough 
      // as we also need the appropriate start positions, therefore sort an index vector

      // initialize indexVector
      vector<int> indexVector; for (unsigned int l=0; l <tp.size() ; l++) indexVector.push_back(l);
      sort(indexVector.begin(), indexVector.end(), scorecomp(tp)); 

      vector<int>::iterator it;
      int l=0;
      for (it = indexVector.begin(); it != indexVector.end(); it++) {
	//cout << l << " " << (*it) << " score = " << tp[(*it)] << " position= " << ts[(*it)] << endl;
	tp_new[l] = tp[(*it)]; ts_new[l] = ts[(*it)];
	l++;
      }      

      copy(tp_new.begin(), tp_new.end(), tp.begin());
      copy(ts_new.begin(), ts_new.end(), ts.begin());

    } // end loop over all scores in current sequence region 

    top_scores[j] = tp;
    top_starts[j] = ts;

  } // end loop over all matrices (forward + backward)
  
  scores.clear();
}


////////////////////////////////////////////////////////////////////////////////////

void score_calc_region(){
  long psem_list_size=psem_motif_matrices.size();

  if (TABLE){
      		*user_gff_file<< seqobj.chrom;
      	}
    
  for (int j = 0;j<psem_list_size;j=j+2){ // loop over all matrices
    
    offset=0;
    motifID=psem_motif_matrices[j].id;
    motifName=psem_motif_matrices[j].TF_name;
    motifSize=psem_motif_matrices[j].motif_length;
    int probs_length = seqobj.seq_length - motifSize + 1; //length of sequence until the last possible match
    regionScore=0;//assign zero affinity to motifs which are longer than the sequence

    if(probs_length>0){
      vector<double> probs(probs_length,0);  //scores stores for one motif matrix at a time
      	
      if(FACT_LNR0)
	lnR0=fact_lnR0;
      else
	lnR0=0.584*motifSize-5.66;
      
      //cout << lnR0 << " " << motifSize << endl;
      transform(probs.begin(),
		probs.end(),
		probs.begin(),										
		getMatrixProb(psem_motif_matrices[j],psem_motif_matrices[j+1]));
    
   for_each(probs.begin(),probs.end(),sumScore);

      probs.clear();

    }
    
    if(regionScore>score_thresh){

    	if (TABLE){
    		*user_gff_file<< "\t" << regionScore;
    	} else {

      *user_gff_file<<seqobj.chrom<<"\tANNOTATE\tregion\t"<<seqobj.seq_start
		    <<"\t"<<(seqobj.seq_start+seqobj.seq_length-1)<<"\t"<<regionScore<<"\t+\t.\tmatrix_id="
		    <<motifID<<";matrix_name="<<motifName<<";seq_id="<<seqobj.id<<";def_L="<<seqobj.defined_length<<endl;
    	}
    }

    regionScore=0; // reinitialize for next matrix

  }
  if (TABLE){
      		*user_gff_file<< endl;
      	}
}


///////////////////////////////////////////////////////////////////////////////////////


void score_calc_region_largest(){
  long psem_list_size=psem_motif_matrices.size();
  long temp_vector;
  for ( int j = 0,i=0;j<psem_list_size;j=j+2,i++){ // loop over all matrices
    
    offset=0;
    motifSize=motif_matrices[j].motif_length;
    
    temp_vector=seqobj.seq_length-motifSize+1;
    if(temp_vector>0) {	
      vector<double> probs((temp_vector),0);  //scores stores for one motif matrix at a time
      lambda=fact_lambda;
      if(FACT_LNR0)
	lnR0=fact_lnR0;
      else
	lnR0=0.584*motifSize-5.66;
      
      transform(probs.begin(),
		probs.end(),
		probs.begin(),										
		getMatrixProb(psem_motif_matrices[j],psem_motif_matrices[j+1]));
      
      for_each(probs.begin(),probs.end(),sumScore);    
      
      if(regionScore>largest_score[i]){
	temp_sequence_start[i]=seqobj.seq_start;
	largest_score[i]=regionScore;
	temp_sequence_end[i]=seqobj.seq_start+seqobj.seq_length-1;
      }
    }
    regionScore=0;
  }
  
}



///////////////////////////////////////////////////////////////////////////////////////

void score_calc_region_top(){
  //cout << "score_calc_region_top: start " << endl;

  long psem_list_size=psem_motif_matrices.size();
  double s_ini = 0.0;            // score to initialize vector
  int k = top_scores[0].size();  // keep k top ranking scores and their corresponding starts
  vector<double> tp_new(k,s_ini); 
  vector<long>   ts_new(k,0);       
  vector<long>   te_new(k,0);       
  
  for ( int j = 0; j<psem_list_size; j=j+2){ // loop over all matrices
    
    offset=0;
    motifSize=motif_matrices[j].motif_length;    
    int probs_length=seqobj.seq_length-motifSize+1;
    //cout <<"probs_length = " << probs_length <<" " <<seqobj.seq_length <<" "<<motifSize<<endl;
    regionScore=0;//assign zero affinity to motifs which are longer than the sequence
    if(probs_length>0) {	

      vector<double> probs(probs_length,0);  //scores stores for one motif matrix at a time

      lambda=fact_lambda;
      if(FACT_LNR0)
	lnR0=fact_lnR0;
      else
	lnR0=0.584*motifSize-5.66;
      
      transform(probs.begin(),
		probs.end(),
		probs.begin(),										
		getMatrixProb(psem_motif_matrices[j],psem_motif_matrices[j+1]));
      
      for_each(probs.begin(),probs.end(),sumScore);    
      
      probs.clear();

    }
    // now the affinity score for the current region resides is stored in regionScore

    // follow the routine score_calc_bindSite_top()
    vector<double> tp = top_scores[j];
    vector<long>   ts = top_starts[j];
    vector<long>   te = top_ends[j];
    //cout << seqobj.chrom<<"\t"<<seqobj.seq_start <<"\t"<<(seqobj.seq_start+seqobj.seq_length-1)<<"\t"<<regionScore<< k-1 << " " << tp[k-1] << endl;


    if (regionScore <= tp[k-1]) continue;   // those affinities will never make it into the top
    tp[k-1] = regionScore  ;                // reset the smallest element of tp
    ts[k-1] = seqobj.seq_start;             // and the corresponding start ts
    te[k-1] = seqobj.seq_start + seqobj.seq_length - 1;  // and the corresponding end te
    
    vector<int> indexVector; 
    for (unsigned int l=0; l <tp.size() ; l++) indexVector.push_back(l);
    sort(indexVector.begin(), indexVector.end(), scorecomp(tp)); 

    vector<int>::iterator it;
    int l=0;
    for (it = indexVector.begin(); it != indexVector.end(); it++) {
      //cout << l << " " << (*it) << " score = " << tp[(*it)] << " position= " << ts[(*it)] << endl;
      tp_new[l] = tp[(*it)]; ts_new[l] = ts[(*it)];  te_new[l] = te[(*it)];
      l++;
    }      
    
    copy(tp_new.begin(), tp_new.end(), tp.begin());
    copy(ts_new.begin(), ts_new.end(), ts.begin());
    copy(te_new.begin(), te_new.end(), te.begin());
    
    top_scores[j] = tp;
    top_starts[j] = ts;
    top_ends[j]   = te;
    
    //for (unsigned int k=0; k<top_scores[j].size(); k++) 
    //cout << "score_calc: " << k << " " << top_starts[j][k] << " "  <<  top_ends[j][k] << " "  << top_scores[j][k] << endl;
    
  }

  regionScore=0;
  
}



///////////////-----------------------------------------------------/////////////////////////
motifMatrix matrix_individual_mask_scoring(motifMatrix & matrix){
	//take half the highest value if average
	if (ANNOTATION_AVERAGE){
		matrix.mask_value = (matrix.mask_value - matrix.min_value)/2; //the mask value contains the maximu value
		}
	// the values in the matrix are mismatch energies.
	//If the nucleotide is a match (bound energy) for a given position, then the mismatch energy has a low value
	// On the contrary, if the nucleotide does not match for a given position, then its mismatch energy is very high.
	// if ANNOTATION_WORSE: the worst mismatch energy value is thus the highest value (best = 0)
	// keep the mask_value at maximum value (= the worst) if not ANNOTATION_AVERAGE
	return matrix;
}

///////////////-----------------------------------------------------/////////////////////////
// function to iterate over all matrices
void matrices_mask_scoring(){
	transform(motif_matrices.begin(),motif_matrices.end(),motif_matrices.begin(),matrix_individual_mask_scoring);
}

///////////////////////////////////////////////////////////////////////////////////////

string long2string(const long i) {
  std::ostringstream stream;
  stream << i;
  return stream.str();
}
string double2string(const double i) {
  std::ostringstream stream;
  stream << i;
  return stream.str();
}

