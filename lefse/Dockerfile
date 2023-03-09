FROM mambaorg/micromamba:0.25.1
ARG VERSION="1.1.2"
RUN micromamba install -y -n base  -c conda-forge -c bioconda -c defaults lefse==${VERSION} && \
    micromamba clean --all --yes
ARG MAMBA_DOCKERFILE_ACTIVATE=1
ENV PATH="/opt/conda/bin:${PATH}"
