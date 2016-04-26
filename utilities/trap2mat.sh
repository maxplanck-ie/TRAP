#! /bin/sh
if [ -z "${TRAPPATH}" ] ; then echo "require environment variable \$TRAPPATH"; exit; fi
if [ -z "${RPATH}" ]    ; then echo "require environment variable \$RPATH"; exit; fi

Rscript=${RPATH}/Rscript
annotate=${TRAPPATH}/bin/ANNOTATE_v3.05
trap2Rdat=${TRAPPATH}/utilities/trap2Rdat.R
splitFile=${TRAPPATH}/utilities/splitFile.pl 

#########################
flags="-g 0.5"
dir=trap.$$
out=trap
proc=1
keep=0

usage() {
      echo
      echo "This is script takes as inputs "
      echo "1. required: a set of sequences    (-s <fasta file>) "
      echo "2. required: a set of motif matrices (-m <position-specific energy matrices>) "
      echo "             each matrix must have a fasta-like header with a unique matrix ID (>matrix_id)"
      echo "3. optional: flags to control TRAP [-f <TRAP-flags>]. Default: $flags "
      echo "4. optional: number of processors [-p <int>]. Split set of motif matrices into \$proc chunks. Default: $proc "
      echo "5. optional: name of output directory [default: -d trap.\$\$ ]"
      echo "6. optional: name of output matrix [default: -o trap.\$\$.Rdat ]"
      echo "7. optional: flag to keep output from ANNOTATE (GFF file): -k"
      echo ""
      echo "Output directory: "
      echo "1. log                        log-file with run time parameters"
      echo "2. two matrices (Rdat files): trap full dataframe (\$out.DF) and simple sequences-motif matrix (\$out.Rdat)"
      echo "3. output from $annotate (gff file): only if -k option is active to keep this file. It is completely redundant with (\$out.DF) and will be deleted by default"
      echo ""
      echo "Usage:"
      echo "$0 -s <sequence file> -m <matrix file>  [-f TRAP flags] [-o <Rdat file>]"
      echo ""
      echo "Example:" 
      echo "$0 -s test.fa -m test.psem -d test_dir"
      echo ""
      echo "The I/O can be large. Be wise and write to a local directory "
      exit 1
}


while getopts s:m:f:p:o:d:k  opt
do
  case $opt in
      s) seq=$OPTARG
          ;;
      m) mat=$OPTARG
          ;;
      f) flags=$OPTARG
          ;;
      p) proc=$OPTARG
          ;;
      o) out=$OPTARG
          ;;
      d) dir=$OPTARG
          ;;
      k) keep=1
          ;;
      \?)
	usage
	;;
  esac
done


shift $(($OPTIND-1))


out=$dir/$out
mdir=$dir/matrices
gdir=$dir/gff
log=$dir/log


if [ ! -f "$seq" ] 
then 
  echo "ERROR: file $seq does not exist"
  usage 
fi

if [ ! -f "$mat" ] 
then 
  echo "ERROR: file $mat does not exist"
  usage 
fi

if [ -d "$dir" ] 
then 
# Notice: it is unwise to overwrite these directories, since they may contain different sets of input matrices
  echo "ERROR: directory $dir exists. Remove or specify new one."
  usage 
fi


mkdir $dir
mkdir $mdir	
mkdir $gdir

regexp="^>"             # regular expression to detect number of matrix entries in $mat (header lines)
prefix=${mdir}/matrix_  # prefix to store chunks of $mat          
gff=`basename $seq .fa`.gff
gff=$dir/$gff



echo "$0 started. Output will be written to $dir" 1>&2
echo "############################" >> $log; date >> $log; 

mats=$mat
nmat=`grep $regexp $mat | wc -l`  # number of entries in $mat
max=$(($nmat/$proc))              # maximal number of chunks = number of entries in $mat / number of processors = integer! 
if [ $max -lt 1 ];
then
  max=1
fi

echo "Split matrix into approx. $proc chunks: $splitFile -m $max -p $prefix -e $regexp $mat" >> $log
$splitFile -m $max -p $prefix -e $regexp $mat


# parallelize $annotate over chunks of matrices
mats=$prefix*   # list of all split matrices (this could also just be one)
for m in $mats
do  
    gfftmp=`basename $m`.gff
    gfftmp=$gdir/$gfftmp
    echo "$annotate -s $seq --psem $m $flags > $gfftmp &" >> $log 
    $annotate -s $seq --psem $m $flags > $gfftmp &
done

# wait for jobs to finish and count failures
FAIL=0
for job in `jobs -p`
do
  wait $job || let "FAIL+=1"
done

if [ "$FAIL" != "0" ];
then
    echo "FAILURE: ($FAIL) jobs failed. " >> $log
    exit
fi

echo "collecting TRAP results: cat $gdir/*gff > $gff" >> $log
cat $gdir/*gff > $gff


# convert gff into Rdat file and matrices
echo "convert $gff to Rdat: $Rscript $trap2Rdat $gff $out" >> $log
$Rscript $trap2Rdat $gff $out


# remove original TRAP output (if not to be kept)
if [ $keep == "0" ];
then
  echo "rm -r $gdir $gff" >> $log
  rm -r $gdir $gff 
fi

echo "$0 finished. " >> $log
date >> $log; 
echo "############################" >> $log; 

echo "$0 finished. Output written to $dir" 1>&2



