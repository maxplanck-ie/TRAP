#! /bin/sh

if [ -z "${TRAPPATH}" ] ; then echo "require environment variable \$TRAPPATH"; exit; fi
if [ -z "${UCSCPATH}" ] ; then echo "require environment variable \$UCSCPATH"; exit; fi

annotate=${TRAPPATH}/bin/ANNOTATE_v3.05
trap2bg=${TRAPPATH}/utilities/trap2bg.pl
w2bw=${UCSCPATH}/wigToBigWig


#########################
run(){
  cmd=$1
  log=$2
  echo $cmd >> $log
  eval $cmd &
}

#########################
flags="-g 0.5 -R 50"
width=0
dir=trap.$$
pattern=""

usage() {
      echo
      echo "This is script takes as inputs "
      echo "1. required: a set of sequences    (-s <fasta file>) "
      echo "2. required: a set of motif matrices (-m <position-specific energy matrices>) "
      echo "             each matrix must have a fasta-like header with a unique matrix ID (>matrix_id)"
      echo "3. optional: pattern to filter on entries in matrix files. Default: undefined "
      echo "4. optional: flags to control TRAP [-f <TRAP-flags>]. Default: $flags "
      echo "5. optional: a genome index to convert bedgraph into bigwig [-g genome.fai ]"
      echo "6. deprecated: width of regions for bigwig file, default=0 (each region will be represented by its midpoint only) [-w int]"
      echo "7. optional: name of output directory [default: -d trap.\$\$ ]"
      echo ""
      echo "Output directory: "
      echo "1. log       log-file with run time parameters"
      echo "2. matrices/ individual matrix files. One for each motif in <-m matrices.psem>"
      echo "3. bedgraph/ bedgraph files with (normalized) TRAP-scores. One for each matrix in matrices/"
      echo "4. bigwig    bigwig files generated from bedgraph (optionally if genome size was specified)"
      echo ""
      echo "Usage:"
      echo "$0 -s <sequence file> -m <matrix file>  [-f TRAP flags] [-g genome size] [-w width] [-o <bedgraph file>]"
      echo ""
      echo "Example:" 
      echo "$0 -s test.fa -m test.psem -g mm9.fa.fai -o test.bg -d reference"
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
      w) width=$OPTARG
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
bgdir=$dir/bedgraph
bwdir=$dir/bigwig

mkdir $dir
mkdir $mdir
mkdir $bgdir

# generate bigwigs only if genome is specified
if [ ! -z ${genome+x} ]; then
   mkdir $bwdir
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
   bg="$bgdir/${bseq}_${mid}.bedgraph" 
   bw="$bwdir/${bseq}_${mid}.bw" 

   convert=""
   if [ ! -z ${genome+x} ]; then
         convert="$w2bw $bg $genome $bw"
   fi	

   run "$annotate -s $seq --psem $m $flags | $trap2bg -norm log | sort -k1,1 -k2,2g > $bg; $convert " $log

   # converting bedgraph--> bigWig
   # if [ ! -z ${genome+x} ]; then
         
	# conversion is easy if bedgraph only contains non-overlapping intervals (i.e. trap with "-S 0")
        # run "$w2bw $bg $genome $bw" $log


        # but the above will fail if bedgraph file contains overlapping windows
        # here we need to define how to represent such "overlapping" scores
	# in general TRAP produces overlapping regions (a,b]
	# region: (a,b] --> midpoint: (p-1,p] where p = (a+b)/2  --> reduced region: (p-1-w, p+w] 

	# the parameter w (default=0) can be used to control the extend of the region around the midpoint
	# w=S/2 might be a sensible choice (where S is the shift of the TRAP)
	# Handle with care; edge effects may still cause overlapping regions, and result in failure!

	# disable: just let the conversion fail
	# awk -v w=$width 'p=($2+$3)/2 { printf("%s\t%d\t%d\t%f\n", $1, p-1-w, p+w, $4)}' $bg | $w2bw stdin $genome $bw

#   fi
done



