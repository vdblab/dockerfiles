FROM condaforge/mambaforge:latest

RUN mamba install -y -c bioconda -c conda-forge fqtk && \
    mamba clean --all -f -y

WORKDIR /data
