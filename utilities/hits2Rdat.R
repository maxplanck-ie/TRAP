# Rscript hits2Rdat.R hits.gff hits_out
# converts gff to Rdat (data.frame) this is specifc to output from ANNOTATE_v3.05

args = commandArgs(trailingOnly=TRUE)

gff = args[1]  # gff-file wiht hits-scores
out = args[2]  # output-file

Rdat=paste(args[2],".DF",sep="")
Rmat=paste(args[2],".mat",sep="")

cmd=paste(" sed -e \'s/[=\\;]/\t/g\' ", gff, "| cut -f1,4-7,10,12,14 ")
stream <- pipe(cmd)
hits=scan(stream, comment.char="#", what=list(chr="",start=0,end=0,score=0,strand="+", matrix_id="",matrix_name="",seq_id=""), quiet=TRUE)         
unlink(stream)

hits=as.data.frame(hits)
saveRDS(hits,file=Rdat)

# cross-tabulation amounts to the number of hits for a given (seq_id, matrix_id) combination
A=xtabs( ~ seq_id + matrix_id, data=hits)
saveRDS(A,file=Rmat)






