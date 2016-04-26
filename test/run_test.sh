if [ -z "${TRAPPATH}" ] ; then echo "require environment variable \$TRAPPATH"; return; fi
if [ -z "${UCSCPATH}" ] ; then echo "require environment variable \$UCSCPATH"; return; fi
if [ -z "${RPATH}" ] ; then echo "require environment variable \$RPATH"; return; fi


TRANSFAC=matrix.dat                    # TRANSFAC matrix file
TRANSPSCM=matrix.pscm                  # TRANSFAC pscm file

UTIL=${TRAPPATH}/utilities
DATA=${TRAPPATH}/data
PSCM=${DATA}/test.pscm        # test pscm file
FA=${DATA}/test.fa            # test fasta file
FAI=${DATA}/mm9.fa.fai        # index file for mouse genome mm9

RES=results.$$
REF=reference_results

mkdir $RES

# 1. Convert TRANSFAC to pscm
# Just for reference: do not run since we do not ship the licensed TRANSFAC file
# python $UTIL/transfac_matrix2pscm.py  $TRANSFAC > $RES/$TRANSPSCM


# 2. Convert pscm to psem, pssm, and summary information (dictionary)
${TRAPPATH}/bin/convert-pscm -g 0.5 --pscm $PSCM --to psem > $RES/test.psem
${TRAPPATH}/bin/convert-pscm -g 0.5 --pscm $PSCM --to pssm > $RES/test.pssm
perl -I ${TRAPPATH}/lib ${UTIL}/pscm2pssm.pl -fm $PSCM -cutoff balanced > $RES/test.balanced.pssm
$UTIL/pssm2summary.sh $RES/test.balanced.pssm > $RES/test.balanced.summary

# 3. Run Annotate programs to generate tracks (using wrappers trap.sh + hits.sh)
$UTIL/trap.sh -s $FA -m $RES/test.psem -f "-g 0.5 -R 100" -g $FAI -d $RES/trap
$UTIL/hits.sh -s $FA -m $RES/test.balanced.pssm -f "-g 0.5 --ttype balanced" -g $FAI -d $RES/hits_balanced
$UTIL/hits.sh -s $FA -m $RES/test.balanced.pssm -f "-g 0.5 -t 2.5 " -g $FAI -d $RES/hits_thresh


# 4. Run Annotate program to generate matrices: motifs vs sequences
$UTIL/trap2mat.sh -s ${DATA}/Mm.1000.promoters.fa -m $RES/test.psem -d $RES/trapMatrix
$UTIL/hits2mat.sh -s ${DATA}/Mm.1000.promoters.fa -m $RES/test.balanced.pssm -d $RES/hitsMatrix

# 5. run simple motif enrichment analysis against gene list (not PASTAA)
${RPATH}/Rscript $UTIL/rankMotifs_groups.R $RES/trapMatrix/trap.mat $DATA/gene.list1 $RES/rankMotifs_groups 
${RPATH}/Rscript $UTIL/rankMotifs_groups.R $RES/trapMatrix/trap.mat $DATA/gene.list1 $RES/rankMotifs_groups_reduceA  reduceA


sleep 3

# log files will differ by date stamp
diff -r -x log $RES $REF > diff.$$

if [ ! -s diff.$$ ];
then
   echo "tested successfully"
   rm diff.$$
else
   echo "differences written to diff.$$"
fi
