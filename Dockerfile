FROM ubuntu:20.04

COPY . /MitoHPC

WORKDIR /MitoHPC/scripts

RUN echo "export HP_SDIR=/MitoHPC/scripts" >> ~/.bashrc

RUN echo $HP_SDIR

RUN bash init.sh

RUN bash install_sysprerequisites.sh

RUN bash install_prerequisites.sh

RUN bash checkInstall.sh

RUN cat checkInstall.log