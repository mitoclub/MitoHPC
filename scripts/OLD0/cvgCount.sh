#!/usr/bin/env bash

#########################################################

#Program that merges coverage statistics
#Input arguments

D=$1  # input directory

##########################################################

if [ $# -eq 1 ] ; then find $D/*/ -name "*cvg.stat" | xargs grep -v min -m 1 -H | egrep -v "mutect2|mutserve" | sort | perl -ane 'BEGIN { print join "\t",("Run","min","q1","q2","q3","max","mean\n") } print "$1\n" if(/.+:(.+)/);' > $D/cvg.tab
                  else find $D/*/ -name "*cvg.stat" | xargs grep -v min -m 1 -H | egrep $2 | sed "s|.$2||"    | sort | perl -ane 'BEGIN { print join "\t",("Run","min","q1","q2","q3","max","mean\n") } print "$1\n" if(/.+:(.+)/);' > $D/cvg.$2.tab
fi