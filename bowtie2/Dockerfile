FROM mambaorg/micromamba:0.25.1
ARG VERSION="2.3.4.1"
RUN micromamba install -y -n base  -c conda-forge -c bioconda -c defaults samtools bedtools bowtie2==${VERSION} pigz && \
    micromamba clean --all --yes
ARG MAMBA_DOCKERFILE_ACTIVATE=1
ENV PATH="/opt/conda/bin:${PATH}"
