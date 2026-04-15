FROM --platform=linux/amd64 condaforge/mambaforge:latest

WORKDIR /app

COPY environment.yml .

RUN mamba env create -f environment.yml && mamba clean -afy

RUN echo "conda activate $(head -1 environment.yml | cut -d' ' -f2)" >> ~/.bashrc

SHELL ["/bin/bash", "--login", "-c"]

COPY . .