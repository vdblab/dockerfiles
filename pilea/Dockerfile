FROM mambaorg/micromamba:0.23.0
ARG VERSION=1.64
USER root
#RUN apt-get update && apt-get install curl wget zip python python3-pip procps -y

RUN micromamba install --name base --channel bioconda --channel conda-forge pilea=1.3.8 -y
ARG MAMBA_DOCKERFILE_ACTIVATE=1
USER mambauser
