FROM condaforge/mambaforge:4.13.0-1
ARG VERSION=1.3
RUN apt-get update && apt-get install -y wget &&  rm -rf /var/lib/apt/lists/* && mamba init bash
#RUN mamba install -y -n base  -c conda-forge -c bioconda -c defaults wget unzip bc
#ARG MAMBA_DOCKERFILE_ACTIVATE=1
#RUN wget https://raw.githubusercontent.com/AnantharamanLab/METABOLIC/f942e155b98c20c479454957a60df249ecdf86d9/METABOLIC_v4.0_env.yml
ADD METABOLIC_v4.0_env.yml ./METABOLIC_v4.0_env.yml
RUN mamba  env update  --name base -f METABOLIC_v4.0_env.yml && \
    mamba clean --all --yes
