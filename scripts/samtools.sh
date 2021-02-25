#!/usr/bin/bash -eux

#SBATCH --job-name=samtools
#SBATCH --partition=shared
#SBATCH --time=24:0:0
#SBATCH --ntasks-per-node=8
#SBATCH --mem=32G

###############################################################

#Program that indexes and counts alignments in a BAM/CRAM file
#Input arguments:
I=$1

################################################################

export N=`basename $I .bam`
export N=`basename $N .cram`
export D=`dirname $I`
MT=chrM
P=8

test -f $I
################################################################

if [ ! -s $I.bai ] && [ ! -s $I.crai ]; then
  samtools index -@ $P $I
fi


if [ ! -s $D/$N.idxstats ] ; then
  #samtools view -@ $P $I -F 0x900 -c     | awk '{print $1,"all"}'    >  $D/$N.count
  #samtools view -@ $P $I -F 0x904 -c     | awk '{print $1,"mapped"}' >> $D/$N.count
  #samtools view -@ $P $I $MT -F 0x904 -c | awk '{print $1,"chrM"}'   >> $D/$N.count
  samtools idxstats -@ $P $I > $D/$N.idxstats
fi

if [ ! -s $D/$N.count ] ; then
  cat $D/$N.idxstats | idxstats2count.pl -sample $N >  $D/$N.count
fi

#to be removed; only for the paper
#if [ ! -s $D/$N.cvg.stat ] ; then
#  samtools depth $I | grep ^$MT | tee $D/$N.cvg | cut -f3 | st  --summary --mean | sed 's|^|'"$N"'\t|' > $D/$N.cvg.stat
#fi
