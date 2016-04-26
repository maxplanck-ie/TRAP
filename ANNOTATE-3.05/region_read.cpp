#include"annotate_sequence.h"
#include"region_read.h"
#include<iostream>

using std::cout;
using std::endl;

// The region is stored in the memory in the form of of 12345...
// A representing 1,C representing 2 and so on......
// this makes direct mapping possible for score score calculation 
// instead of externally defined map

// buffer_size  specifies the region to be read
// REGION_TRUE  specifies if buffer_size is to be enforced
//              if REGION_TRUE = false then read until next sequence header or EOF

bool region_read(long buffer_size,bool REGION_TRUE){
	
  bool eof=false;
  long i=0;
  char nt;

  // read the first sequence region, stop if new sequence header ">" is encountered or if EOF is reached
  nt='\0';
  while(nt!='>' && !user_seq_file->eof()){
    
    // return if buffer size is reached
    if(REGION_TRUE && i>=buffer_size) break;
 
    user_seq_file->get(nt);   
    //cout << nt;

    switch(nt){
      
    case 'a':
    case 'A':seqobj.base_count[0]++;				//increasing base count for A
      seqobj.sequence.push_back(1);			//pushing 1 for A in the buffer
      seqobj.defined_length++;			//increase number of defined characters (A,C,G,T)
      break;
    case 'c':
    case 'C':seqobj.base_count[1]++;				//increasing base count for C
      seqobj.sequence.push_back(2);			//pushing 2 for C in the buffer
      seqobj.defined_length++;			//increase number of defined characters (A,C,G,T)
      break;
    case 'g':
    case 'G':seqobj.base_count[2]++;	//increasing base count for G
      seqobj.sequence.push_back(3);	//pushing 3 for G in the buffer
      seqobj.defined_length++;	       	//increase number of defined characters (A,C,G,T)
      break;
      
    case 't':
    case 'T':seqobj.base_count[3]++;	//increasing base count for T
      seqobj.sequence.push_back(4);	//pushing 4 for T in the buffer
      seqobj.defined_length++;	       	//increase number of defined characters (A,C,G,T)
      break;
      
    case '\n':i--;
      break;
      
    case '>':	     	//'>' signifies start of new sequence, i.e reach end of current sequence
      NEW_SEQUENCE=true;
      user_seq_file->unget();
      return false;   //finish this region_read, but not yet EOF
      
    default:
      if ( GAP && nt == gap_char ) {i--; break;}      // consider this nucleotide as a gap
      seqobj.sequence.push_back(5);					//pushing 5 for N in the buffer
      
    }
    i++;
    
  }
  
  if(user_seq_file->eof()){	
    // reached end of file, just another scenario for reaching the end of current sequence
    eof=true;		       
    NEW_SEQUENCE=true;   
  }					     
  
  return eof;
}
