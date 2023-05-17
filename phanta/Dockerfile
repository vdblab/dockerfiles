FROM mambaorg/micromamba:0.25.1
# TODO: the version is not used yet
ARG VERSION="1.1.0"
RUN micromamba install -y -n base  -c conda-forge -c bioconda -c defaults wget unzip
ARG MAMBA_DOCKERFILE_ACTIVATE=1
RUN cd /home/mambauser/ && wget https://github.com/bhattlab/phanta/archive/refs/tags/v${VERSION}.zip && unzip v${VERSION}.zip
WORKDIR /home/mambauser/phanta-${VERSION}/
RUN micromamba install -y -n base  --file phanta_env.yaml  && \
    micromamba install -y -n base -c conda-forge singularity && \
    micromamba clean --all --yes
RUN mv Snakefile tmp && echo "containerized: 'docker://ghcr.io/vdblab/phanta-${VERSION}'" > Snakefile && cat tmp >> Snakefile
ARG MAMBA_DOCKERFILE_ACTIVATE=1
ENV PATH="/opt/conda/bin:${PATH}"
