FROM mambaorg/micromamba:0.25.1
# TODO: the version is not used yet
ARG VERSION="1.1.0"
RUN micromamba install -y -n base  -c conda-forge -c bioconda -c defaults wget unzip
ARG MAMBA_DOCKERFILE_ACTIVATE=1
RUN wget https://github.com/bhattlab/phanta/archive/refs/tags/v${VERSION}1.1.0.zip && unzip v${VERSION}.zip
RUN micromamba install -y -n base  --file phanta-${VERSION}/phanta_env.yaml  && \
    micromamba clean --all --yes
ARG MAMBA_DOCKERFILE_ACTIVATE=1
ENV PATH="/opt/conda/bin:${PATH}"
