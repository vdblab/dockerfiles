FROM mambaorg/micromamba:0.25.1
ARG VERSION="2.3.4.1"
RUN micromamba install -y -n base  -c conda-forge -c bioconda -c defaults samtools bowtie2==${VERSION} && \
    micromamba clean --all --yes