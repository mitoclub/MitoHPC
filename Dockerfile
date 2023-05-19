FROM ubuntu:20.04

# SHELL ["/bin/bash", "-c"]

COPY . /MitoHPC

WORKDIR /MitoHPC/scripts

#ENV DIRS
ENV HP_HDIR=/MitoHPC
ENV HP_SDIR=/MitoHPC/scripts
ENV HP_BDIR=$HP_HDIR/bin/
ENV HP_JDIR=$HP_HDIR/java/
ENV HP_RDIR=$HP_HDIR/RefSeq/
ENV PATH=$HP_SDIR:$HP_BDIR:$PATH

#hs38DH
ENV HP_RNAME=hs38DH HP_RMT=chrM
ENV HP_RNUMT="chr1:629084-634672 chr17:22521208-22521639"
ENV HP_RURL=ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/GRCh38_reference_genome/GRCh38_full_analysis_set_plus_decoy_hla.fa
ENV HP_E=300

#GENOME REFERENCES
ENV HP_MT=chrM HP_MTC=chrMC HP_MTR=chrMR HP_NUMT=NUMT

# JAVA options
ENV HP_P=1 HP_MM="3G" 
ENV HP_JOPT="-Xms$HP_MM -Xmx$HP_MM -XX:ParallelGCThreads=$HP_P"

RUN printenv | grep HP_ | sort

#install sysprerequisites
RUN apt-get -y update && apt-get upgrade

RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata

RUN apt-get install -y git wget default-jdk default-jre zlib1g libz-dev libncurses5-dev libbz2-dev pkg-config liblzma-dev build-essential unzip  parallel make gcc
RUN apt-get install -y python   # pip
RUN apt-get install -y python-is-python3





RUN bash install_prerequisites.sh

RUN bash checkInstall.sh

RUN cat checkInstall.log



