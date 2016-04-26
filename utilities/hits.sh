#! /bin/sh

if [ -z "${TRAPPATH}" ] ; then echo "require environment variable \$TRAPPATH"; exit; fi
if [ -z "${UCSCPATH}" ] ; then echo "require environment variable \$UCSCPATH"; exit; fi

annotate=${TRAPPATH}/bin/ANNOTATE_v3.05
bed2bb=${UCSCPATH}/bedToBigBed

#########################
run(){
  cmd=$1
  log=$2
  echo $cmd >> $log
  eval $cmd &
}

#########################
flags="-g 0.5"
dir=hits.$$
pattern=""

usage() {
      echo
      echo "This is script takes as inputs "
      echo "1. required: a set of sequences    (-s <fasta file>) "
      echo "2. required: a set of motif matrices (-m <position-specific score matrices>) "
      echo "             each matrix must have a fasta-like header with a unique matrix ID (>matrix_id)"
      echo "3. optional: pattern to filter on entries in matrix files. Default: undefined "
      echo "4. optional: flags to control ANNOTATE [-f <Annotate-flags>]. Default: $flags "
      echo "5. optional: a genome index to convert bed into bigbed [-g genome.fai ]"
      echo "6. optional: name of output directory [default: -d hits.\$\$ ]"
      echo ""
      echo "Output directory: "
      echo "1. log       log-file with run time parameters"
      echo "2. matrices/ individual matrix files. One for each motif in <-m matrices.pssm>"
      echo "3. bedgraph/ bed files (bed6) with hits coords, names, scores, and strands. One file for each matrix in matrices/"
      echo "             Notice: the score are the log-odd scores multiplied by 100 and truncated to integer. This is mainly to convert them to bigbed."
      echo "4. bigbed    bigbed files generated from bed files (optionally if genome size was specified)"
      echo ""
      echo "Usage:"
      echo "$0 -s <sequence file> -m <matrix file>  [-f ANNOTATE flags] [-p regexp pattern] [-g genome size]"
      echo ""
      echo "Example:" 
      echo "$0 -s test.fa -m test.pssm /data/manke/repository/misc/genomes/Mm/mm9/sizes/mm9.fa.fai -d hits_reference"
      exit 1
}


while getopts s:m:p:f:g:w:d:  opt
do
  case $opt in
      s) seq=$OPTARG
          ;;
      m) mat=$OPTARG
          ;;
      p) pattern=$OPTARG
          ;;
      f) flags=$OPTARG
          ;;
      g) genome=$OPTARG
          ;;
      d) dir=$OPTARG
          ;;
      \?)
	usage
	;;
  esac
done


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


shift $(($OPTIND-1))

bseq=`basename $seq .fa`

mdir=$dir/matrices
beddir=$dir/bed
bbdir=$dir/bigbed

mkdir $dir
mkdir $mdir
mkdir $beddir

# generate bigbed only if genome is specified
if [ ! -z ${genome+x} ]; then
   mkdir $bbdir
fi	



log=$dir/log

echo "write to $log" >&2
echo "############################" >> $log; date >> $log; 

# filter matrices: if $pattern is not empty "", print only chunks where the header include a pattern
if [ ! -z $pattern ]; then 
   fmat=`basename $mat`.$pattern
   fmat=$dir/$fmat
   echo "# filter matrix file $mat for $pattern ==> $fmat" >> $log
   awk -v pattern=$pattern '{ if ( /^>/ ) prt=0; if ( /^>/ && $0 ~ pattern ) prt=1; if ( prt == 1 ) print; }' $mat > $fmat
   mat=$fmat      # set the filtered matrix to the new input
fi

# split matrices to treat them separately for speed
echo "# split matrix file $mat into individual chunks: $mdir" >> $log
csplit -f "$mdir/matrix_" -n 5 -s -z $mat "/^>/" {*}

mats=$mdir/matrix_*
for m in $mats
do  

   mid=`head -1 $m  | awk '{print $1}' | sed "s/>//"`   # matrix-ID from header
   bed="$beddir/${bseq}_${mid}.bed" 
   bb="$bbdir/${bseq}_${mid}.bb" 

   convert=""
   if [ ! -z ${genome+x} ]; then
         convert="$bed2bb $bed $genome $bb"
   fi	

   run "$annotate -s $seq --pssm $m $flags | awk 'BEGIN {OFS=\"\t\" } !/^($|#)/ {print \$1, \$4, \$5, \".\", int(100*\$6), \$7}' | sort -k1,1 -k2,2g > $bed; $convert " $log

done



