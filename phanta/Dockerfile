FROM mambaorg/micromamba:0.25.1
# TODO: the version is not used yet
ARG VERSION="2.0.1"
RUN micromamba install -y -n base  -c conda-forge -c bioconda -c defaults wget unzip
ARG MAMBA_DOCKERFILE_ACTIVATE=1
RUN wget https://github.com/bhattlab/phanta/archive/refs/heads/main.zip && unzip main.zip
RUN micromamba install -y -n base  --file phanta-main/phanta_env.yaml  && \
    micromamba clean --all --yes
ARG MAMBA_DOCKERFILE_ACTIVATE=1
ENV PATH="/opt/conda/bin:${PATH}"
