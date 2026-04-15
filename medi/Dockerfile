FROM --platform=linux/amd64 condaforge/mambaforge:latest

WORKDIR /app

COPY medi.yml .

RUN mamba env create -f medi.yml && mamba clean -afy

ENV PATH /opt/conda/envs/medi/bin:$PATH

SHELL ["/bin/bash", "--login", "-c"]

COPY . .