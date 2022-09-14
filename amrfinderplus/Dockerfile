# using micromamba cause a miniconda-based one just gives up trying to solve deps
FROM mambaorg/micromamba:0.23.0
ARG VERSION=3.10.24
USER root
RUN apt-get update && apt-get install curl -y
USER mambauser

RUN micromamba install --name base --channel bioconda --channel conda-forge blast hmmer  wget -y
ARG MAMBA_DOCKERFILE_ACTIVATE=1
RUN mkdir /home/amrfinder/ && cd /home/amrfinder/ && wget https://github.com/ncbi/amr/releases/download/amrfinder_v${VERSION}/amrfinder_binaries_v${VERSION}.tar.gz && tar xvfz amrfinder_binaries_v${VERSION}.tar.gz
WORKDIR /home/amrfinder
# Don't forget to download the latest database
RUN ./amrfinder -u
ENV PATH="/home/amrfinder:/opt/conda/bin:${PATH}"
