FROM mambaorg/micromamba:0.23.0
ARG VERSION=1.64
USER root
RUN apt-get update && apt-get install curl wget zip python python3-pip procps -y

RUN micromamba install --name base --channel bioconda --channel conda-forge diamond
ARG MAMBA_DOCKERFILE_ACTIVATE=1
RUN mkdir /home/mifaser/ && cd /home/mifaser/ && wget https://bitbucket.org/bromberglab/mifaser/get/92323abc14b59e0bf7c558f878a9cfd810f8585e.zip && unzip 92* && cd bromberglab-mifaser-92323abc14b5 && pip3 install .
USER mambauser
