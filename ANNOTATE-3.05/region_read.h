#ifndef REGION_READ_H_
#define REGION_READ_H_

#ifndef VECTOR_H_
#include<vector>
#endif

#ifndef STRING_H_
#include<string>
#endif

#ifndef FSTREAM_H_
#include<fstream>
#endif

using std::vector;
using std::string;

class sequence_object{
 public:
  long base_count[4];
  double base_prob[4];
  long seq_length;
  long defined_length;
  long seq_start;
  long next_seq_start;
  string id;
  string next_id;
  string chrom;
  string next_chrom;
  
  vector<int> sequence;
  
 public:
  sequence_object(){
    base_count[0]=0;
    base_count[1]=0;
    base_count[2]=0;
    base_count[3]=0;
    defined_length=0;
  }
  
  sequence_object(const sequence_object& copy){};
  
  void clear(){
    base_count[0]=0;
    base_count[1]=0;
    base_count[2]=0;
    base_count[3]=0;
    defined_length=0;
    sequence.clear();
  }
  
  void calcExpected_Prob(bool);
};

extern sequence_object seqobj;	
extern std::istream *user_seq_file;
extern std::ostream *user_gff_file;
bool region_read(long,bool);
extern bool NEW_SEQUENCE;
extern bool GAP;
extern bool REGION;


extern int region_overlap;
extern char gap_char;


#endif /*REGION_READ_H_*/
