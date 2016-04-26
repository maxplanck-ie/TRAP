#! /bin/sh

usage() {
      echo "This script extracts summary information for all motif matrices in a *.pssm file as used for ANNOTATE  "
      echo "It implements a simple regexp on the 'fields'. "
      echo "Notice that the column assignment was as for TRANSFAC_2015.pssm. Different version may have different conventions. "
      echo "Example:"
      echo "$0 TRANSFAC_2015.pssm"
      exit 1
}


if [ ! -f "$1" ]; then
   usage
fi


grep "^>" $1  | sed -e "s:'\S*':\t&\t:g" | cut -f 3,5,7,13,15 | sed "s/'//g" | awk 'BEGIN {OFS="\t"; print "#AC", "NAME", "CONSENSUS", "LENGTH", "BALANCED_THRESHOLD"} {print $1, $3, $4, $5, $2}'
