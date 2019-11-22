# TrAP
This repository contains the source code of ANNOTATE (version 3.05). The program is used to annotate DNA sequences with motifs.
The central application contains an implementation of the TRAP algorithm to predict Transcription Factor Affinities as first 
reported in Roider et al. 2007 [1].
The source code alone can also be found here: http://trap.molgen.mpg.de/download/TRAP/ANNOTATE-3.05.tar.gz

Apart from calculating affinities, the program also allows very fast calculation of motif occurence ("hits") in genomic sequences.
The code was initially written by Helge Roider, Abhinab Ray and Thomas Manke. Later modifications were made by Morgane Thomas Chollier.

The primary output of the ANNOTATE program is a GFF file, which can be very large. The main purpose of this repository is to provide several utilities which have been written to convert this into more user-friendly formats such as BED, BEDGRAPH, bigBED and bigWig (for loading into genome browsers).
There are also tools that convert ANNOTATE output into a matrix (seq_id x matrix_id) of TRAP-scores or number of hits.
This matrix is stored in R-format (*.Rdat) and simple R scripts for basic analysis (finding discriminatory motifs) are also provided.


A necessary starting point for all annotation tools is a set of motif matrices that contain the observed nucleotide counts in sequence alignements. This is also known as position-specific count matrices (PSCM). This repository contains a number of tools to convert PSCM into other matrices such as position-specific energy matrices (PSEM) used for TRAP, and position-specific score matrices (PSSM) used by hit-based methods.

Morgane Thomas-Chollier wrote the source code for the convert-pscm tool.
Szymon Kielbasa wrote the pscm2pssm.pl script and the corresponding library (BioMinerva).

Key Publications:

1: Roider HG, Kanhere A, Manke T, Vingron M. Predicting transcription factor
affinities to DNA from a biophysical model. Bioinformatics. 2007 Jan
15;23(2):134-41. Epub 2006 Nov 10. PubMed PMID: 17098775.

2: Thomas-Chollier M, Hufton A, Heinig M, O'Keeffe S, Masri NE, Roider HG, Manke 
T, Vingron M. Transcription factor binding predictions using TRAP for the
analysis of ChIP-seq data and regulatory SNPs. Nat Protoc. 2011 Nov
3;6(12):1860-9. doi: 10.1038/nprot.2011.409. PubMed PMID: 22051799.

3: Roider HG, Manke T, O'Keeffe S, Vingron M, Haas SA. PASTAA: identifying
transcription factors associated with sets of co-regulated genes. Bioinformatics.
2009 Feb 15;25(4):435-42. doi: 10.1093/bioinformatics/btn627. Epub 2008 Dec 9.
PubMed PMID: 19073590; PubMed Central PMCID: PMC2642637.

4: Manke T, Roider HG, Vingron M. Statistical modeling of transcription factor
binding affinities predicts regulatory interactions. PLoS Comput Biol. 2008 Mar
21;4(3):e1000039. doi: 10.1371/journal.pcbi.1000039. PubMed PMID: 18369429;
PubMed Central PMCID: PMC2266803.




