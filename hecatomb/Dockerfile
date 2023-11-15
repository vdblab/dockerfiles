FROM mambaorg/micromamba:0.25.1
ARG VERSION="1.1.0"
RUN micromamba install -y -n base  -c conda-forge -c bioconda -c defaults wget unzip bc python _libgcc_mutex
ARG MAMBA_DOCKERFILE_ACTIVATE=1
RUN cd /home/mambauser/ && wget https://github.com/shandley/hecatomb/archive/refs/tags/v1.2.0.zip && unzip v1.2.0.zip && mv /home/mambauser/hecatomb-1.2.0/ /home/mambauser/hecatomb/
RUN cd /home/mambauser/hecatomb/ && pip install .
WORKDIR /home/mambauser/hecatomb/hecatomb/snakemake/workflow/
ADD env.yaml env.yaml
RUN micromamba install -y -n base  --file env.yaml  && \
    micromamba install -y -n base -c conda-forge singularity && \
    micromamba clean --all --yes
RUN mv Hecatomb.smk tmp && echo "containerized: 'docker://ghcr.io/vdblab/hecatomb:${VERSION}'" > Hecatomb.smk && cat tmp >> Hecatomb.smk

ARG MAMBA_DOCKERFILE_ACTIVATE=1
ENV PATH="/opt/conda/bin:${PATH}"
