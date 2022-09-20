FROM mambaorg/micromamba:0.25.1
ARG VERSION="2.0.1"
RUN micromamba install -y -n base  -c conda-forge -c bioconda -c defaults snap-aligner==${VERSION} && \
    micromamba clean --all --yes
ARG MAMBA_DOCKERFILE_ACTIVATE=1
ENV PATH="/opt/conda/bin:${PATH}"
