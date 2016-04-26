#include"annotate_sequence.h"
#include"matrix.h"
#include"region_read.h"
#include"score_calc.h"
#include<iostream>
#include <cstdlib>
#include "string.h"
#include <algorithm>

using std::cout;
using std::cerr;
using std::endl;

sequence_object seqobj;
vector<double> temp_score;
vector<string> score_print;
vector<long> temp_sequence_start;
vector<long> temp_sequence_end;
vector<double> largest_score;

vector< vector<double> > top_scores;
vector< vector<long> >   top_starts;
vector< vector<long> >   top_ends;

char line[1000];

bool NEW_SEQUENCE=false;
int region_overlap;
long region_count=1;

int get_maximal_width();	
int get_maximal_psem_width();
void get_first_sequence_line();	
void tokenize_seq_header_line();
void reinitialize_largest_temp_variables(long);
void initialize_top_scores();
void output_largest_scores();
void output_largest_affinities();
void add_N();
void slide_update_left_side();


///////////////////////////////////////////////////////////////////////////////////
void calc_hits(){
	
  bool FILE_END_FLAG=false;
  pssm_motif_matrices=motif_matrices;   // store all all the pssm matrices in the pssm_matrices_list
  list_size=pssm_motif_matrices.size(); // size of the generated pssm matrices list
  region_overlap=get_maximal_width();   // routine to calculate the overlap in case the sequence is to be read in parts

  // check against region_overlaps which are too big
  // this could mean that there are matrices with larger width than the region
  // specified for gc-content calculation
  if(REGION && region_overlap>=region_size){
    cout << "annotated_sequence -- ERROR: " <<endl;
    cout << "\tseqobj.seq_length " <<  seqobj.seq_length << " is not larger than region_overlap = " << region_overlap<<endl;
    cout << "\tPick larger region -R or smaller matrices. Exit. " << endl;
    exit(1);
  }

  //cout << "calc_hits: get_first_sequence_line"<<endl;
  get_first_sequence_line();	   // find first line ">" of the sequence file
  tokenize_seq_header_line();      // tokenize the header line of the sequence file

  // read first "region_overlap" basepairs (to  be compatible  with while-loop below)
  //cout << "calc_hits1:read first region " << region_overlap <<endl;
  FILE_END_FLAG=region_read(region_overlap,true);
  seqobj.seq_length=seqobj.sequence.size();// the length of the sequence in the object for the sequence
  /*
  cout << "calc_hits1:  seqobj.seq_id    " << seqobj.id <<endl;
  cout << "calc_hits1:  seqobj.chrom     " << seqobj.chrom <<endl;
  cout << "calc_hits1:  seqobj.seq_start " << seqobj.seq_start <<endl;
  cout << "calc_hits1:  seqobj.seq_length " << seqobj.seq_length <<endl;
  for (unsigned int i=0; i<seqobj.sequence.size(); i++) cout << seqobj.sequence[i];cout<<endl;
  */

  //initialize (largest_score, largest_start,largest_end) for each matrix
  //should be: for each factor
  //if(LARGEST) reinitialize_largest_temp_variables(list_size);
  if(LARGEST) initialize_top_scores();
  
  //loop over sequences along with score calculation
  while(!FILE_END_FLAG){
    
    // read the next sequence fragment to give a sequence of
    // "region_size" or the total sequence if REGION=false
    // Notice that  "region_overlap" basepair are already in the sequence
    // from previous fragment

    FILE_END_FLAG=region_read(region_size-region_overlap,REGION); 
    if(seqobj.sequence.size()==0) continue;
    seqobj.calcExpected_Prob(DEF_GC);  //determine GC-content

    //cout << "annotate_sequence " << seqobj.sequence.size()<<  " ";
    //for (unsigned int i=0; i<seqobj.sequence.size(); i++) cout << seqobj.sequence[i];cout<<endl;
    //cout<<"annotate_sequence: gc_content = " << gc_content << endl;

    //if gc is not specified externally then clear the pssm_motif_matrices
    //and pick score matrices for current gc from a global list 
    if(!EXTN_GC_FLAG){		
      pssm_motif_matrices.clear();
      pick_pssm_matrices();
    }
    


    if (NEW_SEQUENCE) add_N(); // this is a trick described in the routine add_N
    seqobj.seq_length=seqobj.sequence.size();// the length of the sequence in the object for the sequence
    
    //cout <<"calc_hits2:: annotate sequence with seqobj.seq_length " << seqobj.seq_length<<endl;
    //for (unsigned int i=0; i<seqobj.sequence.size(); i++) cout << seqobj.sequence[i];cout<<endl;
 

    if(!LARGEST && !DEBUG){
      score_calc_bindSite();		// annotate the current sequence region with all matrices
    }
    else if(DEBUG)
      score_calc_bindSite_debug();	// same as above, but with debugging information added (matched site)
    else{ 
      score_calc_bindSite_top();	// collect the k largest scores for a sequence  
    }
    
    // NEW_SEQUENCE is true if region_read encountered ">" or EOF
    if(NEW_SEQUENCE){

      NEW_SEQUENCE=false;     // if new sequence is there then no overlap correction is needed
      
      //now is the time to output the largest scores which have been collected
      //in score_calc_bindSite_top();
      if (LARGEST) output_largest_scores();
      
      seqobj.clear();

      if (FILE_END_FLAG) return;  // all file is annotated

      // if there is truely  a new sequence do the initialization  as before
      user_seq_file->getline(line,1000); // get header line ">......."	     
      tokenize_seq_header_line();        // break it apart to determine seqobj.id and possibly /target= (if specified)

      //cout << "calc_hits3:read first region " << region_overlap <<endl;
      FILE_END_FLAG=region_read(region_overlap,true);	
      seqobj.seq_length=seqobj.sequence.size();// the length of the sequence in the object for the sequence
      /*
      cout << "calc_hits3:  seqobj.seq_id    " << seqobj.id <<endl;
      cout << "calc_hits3:  seqobj.chrom     " << seqobj.chrom <<endl;
      cout << "calc_hits3:  seqobj.seq_start " << seqobj.seq_start <<endl;
      cout << "calc_hits3:  seqobj.seq_length " << seqobj.seq_length <<endl;
      for (unsigned int i=0; i<seqobj.sequence.size(); i++) cout << seqobj.sequence[i];cout<<endl;
      */

    }
    else
      // fill next sequence fragment with part of old and adjust base_count
      shift_correction();	 
    

  } // end loop over all regions
  
}


//=======================================================================================
void calc_affinities(){

	bool FILE_END_FLAG=false;
	bool OVERLAP_CALC = false;

	// get matrices
	psem_motif_matrices=motif_matrices;
	list_size=psem_motif_matrices.size(); // size of the generated psem matrices list

	// print table headers
	if (TABLE){
		*user_gff_file<< "SEQID";
		for (int j = 0;j<list_size;j=j+2){ // loop over all matrices
			*user_gff_file<< "\t" << psem_motif_matrices[j].TF_name;
		}
		*user_gff_file<< endl;
	}


	// a given sequence of length L (the sequence between two fasta headers ">" and ">")
	// is annotated as regional fragments
	// "region_overlap" controls the backtracking if the user specifies -S
	// there is an analogue concept for calc_hits,which is there for merely technical reasons
	if(USER_SHIFT)
		//calculating overlap for the affinity based scoring
		region_overlap=region_size-region_shift;
	else
		region_overlap=0;

	// overlap_calc flag
	// The program contains 2 different algorithms, depending on the size of the overlap
	// If the overlap is very large (small shift), recalculating the overlap region decreases performances.
	// In this case, it is more efficient to recalculate only the shift region
	// conversely, if the overlap is very small (large shift, or non-overlapping windows), recalculating the overlap is more performant
	if (USER_SHIFT && region_overlap < region_size/2 ) {
		OVERLAP_CALC = true;
	}

	// search for first ">"
	get_first_sequence_line();
	tokenize_seq_header_line();


	// read "region_overlap" nucelotides to start with
	// these would normally come from the previous chunk of sequence which does not yet exist here
	FILE_END_FLAG=region_read(region_overlap,true);
	seqobj.seq_length=seqobj.sequence.size();// the length of the sequence in the object for the sequence


	if(LARGEST) initialize_top_scores();

	while(!FILE_END_FLAG){

		// "region_overlap" nucleotides have already been read
		// now read what is necessary to obtain a sequence of size "region_size"
		// Notice taht region_read has other site effects then simply to determine
		// the end of file,if a new header line is encountered then also
		// the global variable NEW_SEQUENCE will be set to TRUE

		// Either read the entire sequences (REGION = false), or
		// read the region of desired size (REGION = true) (read the shift region only)
		FILE_END_FLAG=region_read(region_size-region_overlap,REGION);
		seqobj.seq_length = seqobj.sequence.size();


		// if sequence length is zero the skip the particular sequence
		// actually the requirement should be that the sequence is longer than
		// the shortest motif,but this case will ne trapped in score_calc
		if(seqobj.seq_length!=0) {

			// GC content to use
			//determine "background" G+C content (GC-content of the region OR the G+C content given as input)
			seqobj.calcExpected_Prob(DEF_GC);

			//choose the appropriate matrix, depending on the G+C content
			if(!EXTN_GC_FLAG){
				psem_motif_matrices.clear();
				pick_psem_matrices();
			}

			//score the region
			if(!LARGEST) {
				score_calc_region();
			}else{
				score_calc_region_top();
			}
		}

		if(NEW_SEQUENCE){
			NEW_SEQUENCE=false;

			if (LARGEST) output_largest_affinities();

			seqobj.clear();

			if (FILE_END_FLAG) return;  // all file is annotated

			user_seq_file->getline(line,1000); // get header line ">......."
			tokenize_seq_header_line();        // break it apart to determine seqobj.id and possibly /target= (if specified)

			FILE_END_FLAG=region_read(region_overlap,true);
			seqobj.seq_length=seqobj.sequence.size();// the length of the sequence in the object for the sequence

		} else {

			// if NEW_SEQUENCE has not been encountered
			if (OVERLAP_CALC) {
				shift_correction(); // overlap-efficient algo
			} else  {
				slide_update_left_side(); //shift-efficient algo
			}

		} // end if (NEW_SEQUENCE)
	} // while (!FILE_END_FLAG)
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////

int get_maximal_width(){							
  // calculating the overlap size for the windows i.e to be the
  int max_W=0;
  // the size of the largest matrix
  for(unsigned int k=0;k<pssm_motif_matrices.size();k=k+2)
    if(max_W<pssm_motif_matrices[k].get_motif_length())
      max_W=pssm_motif_matrices[k].get_motif_length();
  return max_W;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////

void output_largest_affinities(){

	 if (TABLE){
	      		*user_gff_file<< seqobj.chrom;
	      	}

  long psem_list_size=psem_motif_matrices.size();
  
  for(int i=0,j=0;i<psem_list_size/2;i++,j+=2) {
    
    vector<double> tp = top_scores[j];
    vector<long>   ts = top_starts[j];
    vector<long>   te = top_ends[j];   
    //cout << i << " " << j << " " << tp.size() << endl;
    
    // for each matrix j output the top affinities
    for (unsigned int r=0; r<tp.size(); r++) {
      double score = tp[r];
      long start   = ts[r];
      long end     = te[r];  // in (BUT NOT ALL) cases end=start + region_size - 1
      // if the file ends
      if (TABLE){
        		*user_gff_file<< "\t" << score;
        	} else {
      *user_gff_file<<seqobj.chrom<<"\tANNOTATE\tTF_binding_site\t"<<start
		    <<"\t"<<end<<"\t"<<score<<"\t+\t.\tmatrix_id="
		    <<psem_motif_matrices[j].id<<";matrix_name="
		    <<psem_motif_matrices[j].TF_name<<";seq_id="<<seqobj.id<<endl;
        	}
      
    } // end loop over all ranks
  } // end loop over all matrices
  
  if (TABLE){
      		*user_gff_file<< endl;
      	}

  initialize_top_scores();
  
  
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////

void output_largest_scores(){

  int mmax = pssm_motif_matrices.size();
  for(int m=0; m<mmax; m++) {
    int W = pssm_motif_matrices[m].motif_length;
    vector<double> tp = top_scores[m];
    vector<long>   ts = top_starts[m];
    for (unsigned int r=0; r<tp.size(); r++) {
      double score = tp[r];
      long start = ts[r];
      long end   = start + W - 1;

      *user_gff_file<<seqobj.chrom<<"\tANNOTATE\tTF_binding_site\t"<<start
		    <<"\t"<<end<<"\t"<<score<<"\t"<<pssm_motif_matrices[m].strand<<"\t.\tmatrix_id="
		    <<pssm_motif_matrices[m].id<<";matrix_name="<<pssm_motif_matrices[m].TF_name<<";seq_id="<<seqobj.id<<endl;

    }
  }
  
  //reinitialize_largest_temp_variables(list_size);	
  initialize_top_scores();	
  
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////
void sequence_object::calcExpected_Prob(bool predef_gc){	

	
  long total_base_pairs,total_ACGT,total_base_N;
  
  //cout << "calcExpected_Prob " << sequence.size() << " "; for (int i=0; i<sequence.size(); i++) cout << sequence[i];cout<<endl;

  //calculating the gc for the specified region
  if(predef_gc==false){
    total_ACGT=base_count[0]+base_count[1]+base_count[2]+base_count[3];
    total_base_pairs=seqobj.sequence.size();
    total_base_N=total_base_pairs-total_ACGT;
    gc_content = base_count[1] + base_count[2]+ (total_base_N*0.5);
    gc_content/=total_base_pairs;

    //cout  << "#calcExpected_Prob gc_content " << gc_content <<endl;
    
  } else {

    base_prob[0]=base_prob[3]=(1.0-gc_content)/2;
    base_prob[1]=base_prob[2]=gc_content/2;

  }

  
}


//========================================================================================
void shift_correction(){

  // keep "region_overlap" basepairs from the current seqobj
  // those have not to be read again
  vector<int> tmp;
  
  int i=region_overlap;
  // push the end of the buffer into a temp vector
  while(i>0){
    tmp.push_back(seqobj.sequence[seqobj.sequence.size()-i]);
    i--;
  }
  
  // adjust start coordinate of the new sequence
  seqobj.seq_start += seqobj.sequence.size() - region_overlap;
    
  seqobj.clear(); //clear the sequence and base_counts

  // refill the sequence with element from tmp
  i=0;
  // push the tmp vector into the begining of the sequence 
  while(i<region_overlap) {
    seqobj.sequence.push_back(tmp[i]);

    // to keep track of the total base count
    if(seqobj.sequence[i]==1) {
      seqobj.base_count[0]++;
      seqobj.defined_length++;
    } else if (seqobj.sequence[i]==2) {
      seqobj.base_count[1]++;
      seqobj.defined_length++;
    } else if (seqobj.sequence[i]==3) {
      seqobj.base_count[2]++;
      seqobj.defined_length++;
    } else if (seqobj.sequence[i]==4) {
      seqobj.base_count[3]++;
      seqobj.defined_length++;
    }
 
    i++;
  }
  tmp.clear();

}

//========================================================================================
void slide_update_left_side(){

	int i=0;

	// update the object region base count by removing the shift base count
	while(i<region_shift){

		//cout << "removing "<< seqobj.sequence[i]<< endl;

		if(seqobj.sequence[i]==1) {
			seqobj.base_count[0]--;
			seqobj.defined_length--;
		} else if (seqobj.sequence[i]==2) {
			seqobj.base_count[1]--;
			seqobj.defined_length--;
		} else if (seqobj.sequence[i]==3) {
			seqobj.base_count[2]--;
			seqobj.defined_length--;
		} else if (seqobj.sequence[i]==4) {
			seqobj.base_count[3]--;
			seqobj.defined_length--;
		}
		i++;
	}

	//adjust start coordinate of the new sequence
	seqobj.seq_start += seqobj.sequence.size() - region_overlap;

	//erase sequence if no shift (windows do not overlap)
	if (region_shift == 0){
		seqobj.clear(); //clear the sequence and base_counts
	} else {

		// remove this region from the left of the sequence (overlapping sequences)
		seqobj.sequence.erase(seqobj.sequence.begin(),seqobj.sequence.begin()+region_shift);
		seqobj.seq_length = seqobj.sequence.size();
	}
}

//========================================================================================
void tokenize_seq_header_line(){
	
  const char *id;
  char *reg_start,*chrom,*target;
  string region,chrm;
  bool TARGET=false;
  
  id="N/A";
  target=strtok(line," \t");	//supplying the 1st token for the while loop
  
  // loop over all the tokens
  while(target!=NULL){
    if(strstr(target,"/target")){
      TARGET=true;
      break;
    }
    else if(target[0]=='>')
      id=target;
    target=strtok(NULL," \t");
  }  

  seqobj.id = id;
  seqobj.id.erase(0,1);

  // if the sequence header contains an element "/target=chr:start..end"
  if(TARGET){
    chrom=strtok(target,":");
    reg_start=strtok(NULL,"..");
    seqobj.chrom=chrom;
    
    if(seqobj.chrom[8]=='\'')     // in case the chromosome number is preceeded by "''
      seqobj.chrom.erase(0,9);				
    else
      seqobj.chrom.erase(0,8);
    
    region=reg_start;		            //region start goes here
    seqobj.seq_start=atol(region.c_str());  //here goes the starting position for the
  } else{
    // if /target is not specified
    seqobj.chrom      = seqobj.id;      						
    seqobj.seq_start  = 1;							    
  }

  /*
  cout << "tokenize_seq_header_line: seqobj.seq_start    " << seqobj.seq_start << endl;
  cout << "tokenize_seq_header_line: seqobj.chrom        " << seqobj.chrom << endl;
  cout << "tokenize_seq_header_line: seqobj.id           " << seqobj.id << endl;
  */

}

//========================================================================================
void get_first_sequence_line(){
  
  do
    user_seq_file->getline(line,1000);	
  while(line[0]!='>' && !user_seq_file->eof());

  // case where no ">" has been found => file not in fasta format
  if (line[0]!='>') {
	  cerr<<"ERROR: the format of the sequence file in not correct. Should be a FASTA file "<<endl;
	  exit(1);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// used to generate a new list of SCORE MATRICES from the orginal list of motif_matrices based on the current GC of the region
void calc_pssm_matrices(){
  int i=0;
	
  double eps = 0.00001; 
  // eps is necessary for numerical reasons; example 
  // gc_content=0.275 and (motif_matrices[i].gc = 0.25 or 0.30)
  // this was an attempt to avoid multiple matrices for one factor which all
  // would satisfy the criteria --> see pick_pssm_matrices for a better solution
  while(i<list_size){
    double diff = motif_matrices[i].gc - gc_content;
    i++;

    // this prescription assumes that precalculated gc-contents are equally spaced by 0.05 
    if (diff < -0.025+eps) continue;
    if (diff >  0.025+eps) continue;
    

    cout << gc_content << " --> picked " << motif_matrices[i-1].gc << endl;
    pssm_motif_matrices.push_back(motif_matrices[i-1]);
    
  }

  // if  newly generated list is not eqaul to the original identities of the matrices
  // then skip calculation
  if(pssm_motif_matrices.size()!=2*matrices_identities_map.size()){
    cerr<<"ERROR: no pssm matrices available for the region with sequence id='"<<seqobj.id<<"' start='"
	<<seqobj.seq_start<<"' and gc='"<<gc_content<<"'"<<endl;
    cerr << "sequence = " << endl;
    for (unsigned int j=0;j<seqobj.sequence.size();j++) cerr << seqobj.sequence[j];
    cerr << endl;

    exit(1);
  }
    
  //cout << "selected 

}




// this routine picks an energy matrix (from a precalculated list) according to the current gc_content
void calc_psem_matrices(){
  int i=0;
  
  double eps = 0.00001; 
  // eps is necessary for numerical reasons; example 
  // gc_content=0.275 and (motif_matrices[i].gc = 0.25 or 0.30)

  while(i<list_size){
    double diff = motif_matrices[i].gc - gc_content;
    i++;
    if (diff < -0.025+eps) continue;
    if (diff >  0.025+eps) continue;

    //cout << gc_content << " --> picked " << motif_matrices[i-1].gc << endl;
    //printf("%d   %28.24f   %28.24f   %28.24f\n",i,motif_matrices[i].gc,gc_content,diff);

    // This solution has problems with numerical accuracy
    //if( gc_content>=(motif_matrices[i].gc-0.025-eps) && gc_content< (motif_matrices[i].gc + 0.025)){
    // psem_motif_matrices.push_back(motif_matrices[i]);
    //}
 
    psem_motif_matrices.push_back(motif_matrices[i-1]);
    //cout << "pushed back " <<  motif_matrices[i-1].gc << " " << gc_content << " " << diff << endl;
  }


  // simple check: this finally checks whether the number of matrices used makes sense
  // need 2 matrices (=two strands) for each factor
  if(psem_motif_matrices.size()!=2*matrices_identities_map.size()){
    cerr<<endl<<matrices_identities_map.size()<<"\t\t"<<psem_motif_matrices.size()<<endl;
    cerr<<"ERROR -calc_psem_matrices:  no psem matrices available for the region with sequence id='"<<seqobj.id<<"' \nstart='"
	<<seqobj.seq_start<<"'  and gc='"<<gc_content<<"'"<<endl;
    cerr << "sequence = " << endl;
    for (unsigned int j=0;j<seqobj.sequence.size();j++) cerr << seqobj.sequence[j];
    cerr << endl;
    
    exit(1);
  }

}
////////////////////////////////////////////////////////////////////////////////////////////////
// pick appropriate matrices given current gc_content 
void pick_pssm_matrices(){

  // This is a more accurate version of calc_pssm_matrices, 
  // but I am somewhat concerned about speed-issues (remains to be tested)
  // also it would be nice to pick the closest matrix in terms of its gc-content
  // rather than simply the first best
  // Here I DO assume that the reverse matrix always follows its forward matrix and has the same gc
  // I do NOT assume any ordering of matrix identifiers according to their gc-content in numerical order
  // for a given matrix I simply take the first matrix that falls close enough to the current gc-content
  // I do NOT consider the case where a subsequent matrix maybe an even better approximation
  // to the current gc-content

  double eps = 0.00001; 
  int i=0;
  map <string,bool> already_pushed;
	
  while(i<list_size){
    double diff = motif_matrices[i].gc - gc_content;
    string id   = motif_matrices[i].id;
    i+=2;

    // this prescription assumes that precalculated gc-contents are equally spaced by 0.05 
    if (diff < -0.025+eps) continue;
    if (diff >  0.025+eps) continue;

    // more than one matrix for a given id may satisfy the above criteria
    // take only the first to match (actually the first two = forward and reverse)
    if ( already_pushed.find(id) != already_pushed.end() ) {
      // do nothing
    } else {
      already_pushed[id]=true; 
      //cout << gc_content << "-> picked " << motif_matrices[i-2].gc << " " <<  motif_matrices[i-1].gc <<endl;
      pssm_motif_matrices.push_back(motif_matrices[i-2]);  // forward matrix
      pssm_motif_matrices.push_back(motif_matrices[i-1]);  // reverse
    }
  }

  // this check should be redundant, but I leave it here for security
  // as I had thought of it as redundant before, when it actually still pointed to possible errors
  // if  newly generated list is not eqaul to the original identities of the matrices
  // then skip calculation
  if(pssm_motif_matrices.size()!=2*matrices_identities_map.size()){
    cerr<<"ERROR - pick_pssm_matrices: no pssm matrices available for the region with sequence id='"<<seqobj.id<<"' start='"
	<<seqobj.seq_start<<"' and gc='"<<gc_content<<"'"<<endl;
    cerr << "sequence = " << endl;
    for (unsigned int j=0;j<seqobj.sequence.size();j++) cerr << seqobj.sequence[j];
    cerr << endl;

    exit(1);
  }
    
  //cout << "selected 

}



///////////////////////////////////////////////////////////////////////////////////////////////////////
// this routine picks an energy matrix (from a precalculated list) according to the current gc_content
void pick_psem_matrices(){

  // see description of pick_pssm_matrices()
  double eps = 0.00001; 
  int i=0;
  map <string,bool> already_pushed;
  
  while(i<list_size){
   double diff = motif_matrices[i].gc - gc_content;
    string id   = motif_matrices[i].id;
    i+=2;

    if (diff < -0.025+eps) continue;
    if (diff >  0.025+eps) continue;

    if ( already_pushed.find(id) != already_pushed.end() ) {
      // do nothing
    } else {
        already_pushed[id]=true;
        //cout << gc_content << "-> picked " << motif_matrices[i-2].gc << " " <<  motif_matrices[i-1].gc <<endl;
        psem_motif_matrices.push_back(motif_matrices[i-2]);  // forward matrix
        psem_motif_matrices.push_back(motif_matrices[i-1]);  // reverse
      }
    }


    // simple check: this finally checks whether the number of matrices used makes sense
    // need 2 matrices (=two strands) for each factor
    if(psem_motif_matrices.size()!=2*matrices_identities_map.size()){
      cerr<<endl<<matrices_identities_map.size()<<"\t\t"<<psem_motif_matrices.size()<<endl;
      cerr<<"ERROR -pick_psem_matrices:  no psem matrices available for the region with sequence id='"<<seqobj.id<<"' \nstart='"
  	<<seqobj.seq_start<<"'  and gc='"<<gc_content<<"'"<<endl;
      cerr << "sequence = " << endl;
      for (unsigned int j=0;j<seqobj.sequence.size();j++) cerr << seqobj.sequence[j];
      cerr << endl;

      exit(1);
    }
}
/////////////////////////////////////////////////////////////////////////////////////////////
void add_N(){
  // here comes Ray's trick:
  // remember that the score calculation will not run over the whole region (=current sequence) 
  // but only up to sequence_length - region_overlap
  // the remaining "region_overlap" basepairs will normally be annotated as
  // part of the next sequence.
  // However, this assumes that the sequence is actually longer than the region
  // which is currently in memory. If,howeer, the sequence does NOT extend beyond
  // the current region, then we would be missing this last part.
  // Therefore we add some mock sequence here, just so that score_calc_*
  // covers all. 
  // 5=N is added as this will not produce any spurious hits.
  
  for(int k=0;k<region_overlap;k++)  seqobj.sequence.push_back(5);	     

}
/////////////////////////////////////////////////////////////////////////////////////////////
void reinitialize_largest_temp_variables(long size_temp_variables){

  largest_score.clear();
  temp_sequence_start.clear();
  temp_sequence_end.clear();					

  for(int i=0;i<(size_temp_variables);i++)
    largest_score.push_back(-1000);

  for(int i=0;i<(size_temp_variables);i++)
    temp_sequence_start.push_back(0);
  
  for(int i=0;i<(size_temp_variables);i++)
    temp_sequence_end.push_back(0);
}

////////////////////////////////////////////////////////////////
void initialize_top_scores(){

  //int mmax = list_size;
  int mmax = 2*matrices_identities_map.size();
  top_scores.clear();
  top_starts.clear();
  top_ends.clear();

  //cout << "initialize_top_scores: push " << number_of_top_scores << endl;

  vector<double> scores;
  vector<long>   starts;
  vector<long>   ends;

  for (int r=0;r<number_of_top_scores;r++) scores.push_back(-1000);
  for (int r=0;r<number_of_top_scores;r++) starts.push_back(0);
  for (int r=0;r<number_of_top_scores;r++) ends.push_back(0);
  
  for(int m=0; m<mmax; m++) {
    top_scores.push_back(scores);
    top_starts.push_back(starts);
    top_ends.push_back(ends);
  }

  //cout << "initialize_top_scores: end " << endl;

}
