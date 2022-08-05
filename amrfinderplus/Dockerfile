# using micromamba cause a miniconda-based one just gives up trying to solve deps
#FROM continuumio/miniconda3
#RUN

FROM mambaorg/micromamba:0.23.0
USER root
RUN apt-get update && apt-get install curl -y
USER mambauser

RUN micromamba install --name base --channel bioconda --channel conda-forge blast hmmer  wget -y
ARG MAMBA_DOCKERFILE_ACTIVATE=1
RUN mkdir /home/amrfinder/ && cd /home/amrfinder/ && wget "https://github.com/ncbi/amr/releases/download/amrfinder_v3.10.24/amrfinder_binaries_v3.10.24.tar.gz" && tar xvfz amrfinder_binaries_v3.10.24.tar.gz
WORKDIR /home/amrfinder
# Don't forget to download the latest database
RUN ./amrfinder -u
ENV PATH="/home/amrfinder:/opt/conda/bin:${PATH}"
