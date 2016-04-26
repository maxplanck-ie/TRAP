
# load libraries
library(parallel)
library(reshape2)

# define functions
# passing sequence ids (seq1, seq2) explicitly
#wt = function(x) { wilcox.test (A[seq1,x], A[seq2,x])$p.value  }   # two-sided wilcox p-value
#lf = function(x) { log2(  mean(A[seq1,x])/mean(A[seq2,x])  )   }   # log2-fold change

# passing group-ids
lf  = function(x) { rr=aggregate(A[,x] ~ groups, as.data.frame(A[,x]), mean ); return (log2(rr[1,2]/rr[2,2])) }
wt  = function(x) { wilcox.test (A[,x] ~ groups)$p.value  }         # two-sided wilcox p-value
kt  = function(x) { kruskal.test(A[,x] ~ groups)$p.value }          # kruskal test for multiple groups  
lmf = function(x) { lm( A[,x] ~ groups )  }                         # define linear model of TRAP-score as function of group


# define global variables
myred=rgb(1,0,0,0.5)
myblue=rgb(0,0,1,0.5)
myyellow=rgb(1,1,0,0.5)
#pid=Sys.getpid()     # process id (not needed)


########################################################################
# Read Data
usage=
"This script takes as input
	1. a sequence-motif matrix A of TRAP-scores: trap.mat, (Rdat file)
	2. a list seqs of sequence ids (optionally with group labels): gene.list (ascii [2-column]) 
	4. output directory to indicate whether the matrix A should be reduced to entries listed in seqs
	4. an optional flag \"reduceA\" to indicate whether the matrix A should be reduced to entries listed in seqs

The script outputs a directory with *tsv files of ranked motif list according to some group test
        a. For two groups a Wilcoxon test is performed (wilcox.tsv)
	b. For two or more groups a Kruskal-Wallis test is performed (kurskal.tsv)
        c. A box plot for the top motifs is also generated (kruskal.jpg)

Usage: /package/R-3.2.3/bin/Rscript rankMotifs_groups.R trap.mat gene.list out.directory [ reduceA ]\n"

args = commandArgs(trailingOnly=TRUE)
la=length(args)
if (la<3) { cat(usage); stop() } 


f1=args[1]
f2=args[2]
dn=args[3]

dir.create(dn, recursive=TRUE)
cat("write results to directory", dn, "\n")

A    = readRDS(f1)                   # read matrix of TRAP-scores
seqs = read.table(f2,row.names=1)    # read list of sequence. Possibly with unique group annotations (seqs$V2). No duplicated rownames

reduceA=FALSE                        # default: do _not_ reduce matrix A
if (la>3) { reduceA= grepl( paste0("^",args(4)), "reduceA",ignore.case=TRUE) }  # TRUE if third argument is specified and is (or appreviates) "reduceA"

if (reduceA) {
  i=which(rownames(seqs) %in% rownames(A))
  A=A[i,]
}

N = nrow(A)         # number of sequences
M = ncol(A)         # number of motif matrices
nlist=rownames(A)   # list of all sequence_ids
mlist=colnames(A)   # list of all matrix_ids

# assign unique group names (=factors) to sequences
if (ncol(seqs)==0) { seqs$V2=factor("signal") }    # if groups are not explicitly named in seqs, then call this group "signal"
groups=gl(1, nrow(A))                              # create groups for all genes in A
levels(groups)=c("backgroundA",levels(seqs$V2))    # define levels of all groups in A, default group: "backgroundA"
i=which(rownames(A) %in% rownames(seqs))
groups[i]=seqs[rownames(A[i,]), "V2"]              # set group level to those defined by seqs


#table(groups)                                      # some levels may not have any support if they are filtered out
groups=droplevels(groups)                          # drop all levels that are not supported by data in A (i.e. groups that only exist in list seqs)
nl=nlevels(groups)                                 # number of levels defined in groups 
tb=table(groups)                                      # should not have any zero entries
tb

########################################################################
# Define Compute Cluster for parallel processing: --> parSapply
cl=makeCluster(8)
clusterExport(cl,c("groups","A"))   # pass objects to cluster

########################################################################
# Wilcoxon Test: two sets analysis (nl=2)
# find motifs with significant TRAP differences in two-sets of sequences
if (nl == 2) {
	log2FC<-parSapply(cl, mlist, lf)     # parallelize fold-change calculation over list of motifs mlist
	pvalues<-parSapply(cl, mlist, wt)    # parallelize wilcoxon test pvalue calculation over list of motifs mlist
	fdr = p.adjust(pvalues, method="fdr")

	res = rbind(log2FC = log2FC, pvalue=pvalues, fdr=fdr )
	res = t(res)                            # transpose
	res = res[order(res[,"pvalue"]),]       # order by p-values

	fn=paste(dn,'/wilcox.tsv',sep="")
	cat(file=fn, "#Wilcoxon test. N=",N," M=",M,"\n")
	cat(file=fn, "#groups: ",names(tb), "\n", append=TRUE)
	cat(file=fn, "#sizes:  ",tb,"\n", append=TRUE)
	cat(file=fn, "#matrix","log2FC", "pvalue","fdr","\n",sep="\t",append=TRUE)
	write.table(file=fn, res, quote=FALSE,col.names=FALSE, sep="\t", append=TRUE)
}
########################################################################
# Kruskal test: multiple groups of sequences (includes nl=2)
pvalues<-parSapply(cl,mlist,kt)      # parallelize Kruskal test for each motif in mlist
fdr=p.adjust(pvalues,method="fdr")
res=data.frame(pvalue=pvalues,fdr=fdr)

##########################
# Anova model: normality assumption
#models       = parSapply(cl,  mlist, lmf, simplify=FALSE)
#anova_tables = parSapply(cl, models, anova, simplify=FALSE)
#anovap=lapply(anova_tables, function(x) x$"Pr(>F)"[[1]])
#res$anovap=unlist(anovap)
##########################

res=res[order(res[,"pvalue"]),]                                              # sort results by pvalue
fn=paste(dn,"/kruskal.tsv",sep="")                                           # filename for output
cat(file=fn,"#Kruskal test. N=", N, " M=", M, "\n")                          # print header information
cat(file=fn,"#groups:", levels(groups), "\n",append=TRUE)
cat(file=fn,"#sizes: ", table(groups), "\n",append=TRUE)
cat(file=fn,"#matrix", names(res), "\n", sep="\t", append=TRUE)
write.table(file=fn, res,quote=FALSE, col.names = FALSE, sep="\t",append=TRUE)

########################################################################
# boxplot top-results to jpeg
jpeg(  paste(dn,"/kruskal.jpg",sep="")  )  # open jpeg file
top=which(res[,"fdr"]<0.05)                # define top results (based on Kruskal-test (FDR)
if (length(top)<3) { top=1:3 }             # show at least the top three motifs

DF=as.data.frame(A[,rownames(res)[top]])   # convert top entries of A to data frame: prepare for efficient boxplot
mn=names(DF)                               # keep motif names
DF$groups=groups                           # assign groups to DF

DF=melt(DF, value.name="TRAP", id.vars="groups", variable.name="motif")
bp=boxplot(TRAP~groups*motif,data=DF,col=rainbow(nl),horizontal=TRUE,las=1,boxwex=0.5,xlab="TRAP-score",notch=TRUE, main="Significant Motifs",yaxt="n")

xp=min(DF$TRAP)*0.95                     # x-position  for text
yps=0.5 + seq(1, nl*length(mn), by=nl)   # y-positions for text 
fdrs=sprintf("%2.3e",res[top,"fdr"])     # fdr-values for each motif to be plotted at (x,y)

axis(2, labels=mn,at=yps,las=2)                                                 # plot y-axis with motif names
text(xp, yps,labels = fdrs,cex = 0.75)                                          # set text (fdr-values)
legend("topright",inset=0.03, legend=levels(groups), fill=rainbow(nl), cex=0.8) # plot legend for nl group levels
do=dev.off()
########################################################################


stopCluster(cl)


# deprecated: saving all data objects for subsequent analysis
# this was never much used and may leave an unnecessarily large storage footprint
# sn=paste0(dn, "/rankMotifs_groups.Rdata")
# save.image(file=sn)
