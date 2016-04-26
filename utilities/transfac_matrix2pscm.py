'''
//
AC  M00001
XX
ID  V$MYOD_01
XX
DT  19.10.1992 (created); ewi.
DT  22.10.1997 (updated); dbo.
CO  Copyright (C), Biobase GmbH.
VV  TRANSFAC MATRIX TABLE, Release 2011.2 - licensed - 2011-06-30, (C) Biobase GmbH
XX
//
AC  M00001
XX
ID  V$MYOD_01
XX
DT  19.10.1992 (created); ewi.
DT  22.10.1997 (updated); dbo.
CO  Copyright (C), Biobase GmbH.
XX
NA  MyoD
XX
DE  myoblast determination gene product
XX
BF  T01128; MyoD; Species: chick, Gallus gallus.
BF  T15547; MyoD; Species: chick, Gallus gallus.
BF  T00524; MyoD; Species: clawed frog, Xenopus laevis.
BF  T10010; MyoD; Species: clawed frog, Xenopus laevis.
BF  T03902; MyoD; Species: common carp, Cyprinus carpio.
BF  T00525; MyoD; Species: human, Homo sapiens.
BF  T09197; MyoD; Species: human, Homo sapiens.
BF  T10027; MyoD; Species: Mammalia.
BF  T00527; MyoD; Species: monkey, Cercopithecus aethiops.
BF  T09177; MyoD; Species: mouse, Mus musculus.
BF  T00526; MyoD; Species: mouse, Mus musculus.
BF  T01551; MyoD; Species: quail, Coturnix coturnix.
BF  T15572; MyoD; Species: rat, Rattus norvegicus.
BF  T15571; MyoD; Species: rat, Rattus norvegicus.
BF  T03907; MyoD; Species: zebra fish, Brachydanio rerio.
BF  T03912; MyoD (275 AA); Species: rainbow trout, Oncorhynchus mykiss.
BF  T03911; MyoD (376 AA); Species: rainbow trout, Oncorhynchus mykiss.
XX
P0      A      C      G      T
01      1      2      2      0      S
02      2      1      2      0      R
03      3      0      1      1      A
04      0      5      0      0      C
05      5      0      0      0      A
06      0      0      4      1      G
07      0      1      4      0      G
08      0      0      0      5      T
09      0      0      5      0      G
10      0      1      2      2      K
11      0      2      0      3      Y
12      1      0      3      1      G
XX
BA  5 functional elements in 3 genes
XX
//

>M00001 /AC='M00001' /name='V$MYOD_01' /type='pscm' /consensus='SRACAGGTGKYG' /size='12'
1	2	2	0	S
2	1	2	0	R
3	0	1	1	A
0	5	0	0	C
5	0	0	0	A
0	0	4	1	G
0	1	4	0	G
0	0	0	5	T
0	0	5	0	G
0	1	2	2	K
0	2	0	3	Y
1	0	3	1	G
'''

import sys


def my_read(handle):
    annotations = {}
    references = []
    counts = None
    records = []
    record = {}
    for line in handle:
        line = line.strip()
        key, value = line[:2], line[4:]
        
        if key in ('P0', 'PO'): # Old TRANSFAC files use PO instead of P0 
            counts = []
            sequence = ""
            assert value.split()[:4]==['A', 'C', 'G', 'T']
            length = 0
            for line in handle:
                key, value = line[:2], line[4:]
                try:
                    i = int(key)
                except ValueError:
                    break
                length+=1
                assert i==length
                
                values = value.split()
                sequence += values[4]
                counts.append(values[0:4])
        if line=='XX':
            pass
        elif key=='AC':
            record["AC"] = value
        elif key=='ID':
            record["ID"] = value
        elif key=='//':
            if counts is not None:
                record["counts"] = counts
                record["sequence"] = sequence
                records.append(record)
            annotations = {}
            references = []            
            record = {}
        else:
            pass
    return records

handle = open(sys.argv[1])
#handle = open("matrix.dat")
records = my_read(handle)
handle.close()

for m in records:
    
    try:
        m["counts"] = map(lambda x: map(int,x),m["counts"])
    except ValueError:
        continue
    
    rowsum1 = True
    for c in m["counts"]:
        rowsum1 = rowsum1 and sum(c) == 1
        
    if not rowsum1:
        size = len(m["sequence"])
        name = m["ID"].replace(":","_")
        print ">%s /AC='%s' /name='%s' /type='pscm' /consensus='%s' /size='%s'" % (m["AC"],m["AC"],name,m["sequence"],size)
        
        for i in range(size):
            print "%s\t%s" % ("\t".join(map(str,m["counts"][i])),m["sequence"][i])
            


    
    
    

