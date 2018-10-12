# Author: T.Manke
# Date: 12.10.2018

'''
MEME version 4.4

ALPHABET= ACGT

strands: + -

Background letter frequencies (from meme_chip/background):
A 0.30000 C 0.20000 G 0.20000 T 0.30000 

MOTIF Beaf-32 

letter-probability matrix: alength= 4 w= 10 nsites= 285 E= 3.3e-230
  0.182456	  0.249123	  0.007018	  0.561404	
  0.842105	  0.000000	  0.052632	  0.105263	
  0.000000	  0.108772	  0.000000	  0.891228	
  0.000000	  1.000000	  0.000000	  0.000000	
  0.000000	  0.000000	  1.000000	  0.000000	
  1.000000	  0.000000	  0.000000	  0.000000	
  0.000000	  0.000000	  0.000000	  1.000000	
  0.800000	  0.000000	  0.056140	  0.143860	
  0.157895	  0.059649	  0.564912	  0.217544	
  0.021053	  0.435088	  0.136842	  0.407018	

MOTIF CTCF 

letter-probability matrix: alength= 4 w= 11 nsites= 189 E= 8.2e-197
  0.412698	  0.370370	  0.164021	  0.052910	
  0.105820	  0.407407	  0.026455	  0.460317	
  0.920635	  0.000000	  0.037037	  0.042328	
  0.058201	  0.000000	  0.925926	  0.015873	
  0.476190	  0.015873	  0.507937	  0.000000	
  0.000000	  0.037037	  0.185185	  0.777778	
  0.000000	  0.000000	  1.000000	  0.000000	
  0.010582	  0.000000	  0.941799	  0.047619	
  0.121693	  0.862434	  0.000000	  0.015873	
  0.000000	  0.000000	  0.947090	  0.052910	
  0.037037	  0.777778	  0.047619	  0.137566	

//


>Beaf-32 /name='Beaf-32' /type='pscm' /nsites='285' /width='10'
52	71	2	160	
240	0	15	30	
0	31	0	254	
0	285	0	0	
0	0	285	0	
285	0	0	0	
0	0	0	285	
228	0	16	41	
45	17	161	62	
6	124	39	116	
>CTCF /name='CTCF' /type='pscm' /nsites='189' /width='11'
78	70	31	10	
20	77	5	87	
174	0	7	8	
11	0	175	3	
90	3	96	0	
0	7	35	147	
0	0	189	0	
2	0	178	9	
23	163	0	3	
0	0	179	10	
7	147	9	26	
'''

import sys

# from https://stackoverflow.com/questions/5574702/how-to-print-to-stderr-in-python
#def eprint(*args, **kwargs):
#    print(*args, file=sys.stderr, **kwargs)


def my_read(handle):
    records = []
    record = {}
    counts = None

    for line in handle:
        line = line.strip()

        if not line:   
            continue	# skip empty lines

        fields= line.split()
#	print fields
#	print  "line=%s\tfields[0]=%s" % (line, fields[0])

        if fields[0] == 'MOTIF':
            record["AC"]=fields[1]

        if fields[0] == "letter-probability":
	    # read header information
            record["width"]=int(fields[5])
	    record["nsites"]=int(fields[7])
#	    print  "w=%i\t%i" % (record["width"],record["nsites"])

	    # reset count-matrix
	    counts = []

	    # collect counts
	    for line in handle:

		if not line.strip():
#		    print "finished reading counts: width=%i" % (record["width"])
		    break

	        line_counts = line.strip().split()              # meme stores the fractions of counts
		line_counts =[float(d) for d in line_counts]    # convert characters to double
	        		
		# multiply fractions with nsites and round to get integer counts	
		line_counts = [int(round(x*record["nsites"])) for x in line_counts]   

#                print line_counts[0:4]
	        counts.append(line_counts[0:4])

	    record["counts"]=counts

	    # loop over probability matrix finished
	  
	    if counts is not None:
#		print(record["AC"], " : ", counts)
	        records.append(record)
		record = {}

    return records

######################

handle = open(sys.argv[1])
#handle = open("../data/all_motifs.meme")
records = my_read(handle)
handle.close()

for m in records:
    
    try:
        m["counts"] = map(lambda x: map(int,x),m["counts"])
    except ValueError:
        continue
    
    # print header
    print ">%s /name='%s' /type='pscm' /nsites='%s' /width='%s'" % (m["AC"],m["AC"],m["nsites"],m["width"])

    # print count matrix
    for i in range(m["width"]):
        #print(m["counts"][0:4])
        print "%s\t" % ("\t".join(map(str,m["counts"][i])))
            


    
    
    

