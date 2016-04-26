# Rscript trap2Rdat.R trap.gff trap_out
# converts gff to Rdat (data.frame) this is specifc to output from ANNOTATE_v3.05

args = commandArgs(trailingOnly=TRUE)

gff = args[1]  # gff-file wiht trap-scores
out = args[2]  # output-file

Rdat=paste(args[2],".DF",sep="")
Rmat=paste(args[2],".mat",sep="")

cmd=paste(" sed -e \'s/[=\\;]/\t/g\' ", gff, "| cut -f1,4-7,10,12,14,16 ")
stream <- pipe(cmd)
trap=scan(stream, comment.char="#", what=list(chr="",start=0,end=0,score=0,strand="+", matrix_id="",matrix_name="",seq_id="",eff_length=0), quiet=TRUE)         
unlink(stream)

trap=as.data.frame(trap)
trap$norm_score=log(trap$score/trap$eff_length)

#write.table(trap,file=Rdat,quote=FALSE, sep="\t",row.names=FALSE)
saveRDS(trap,file=Rdat)


###### filter and convert to (seq-mat) matrix with normalized TRAP-scores
discard=which(trap$eff_length==0)
if (length(discard)>0) { trap=trap[-discard,] }
A=xtabs(norm_score ~ seq_id + matrix_id, data=trap)
saveRDS(A,file=Rmat)





#old conversion:
#A=trap[,c("seq_id","matrix_id","norm_score")]
#A=tapply(A$norm_score,mat[1:2],c)



