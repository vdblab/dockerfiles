FROM mambaorg/micromamba:0.25.1
ARG VERSION=1.3
RUN micromamba install -y -n base  -c conda-forge -c bioconda -c defaults python=2.7 biopython checkm-genome wget "libopenblas=*=openmp*" && \
    micromamba clean --all --yes
ARG MAMBA_DOCKERFILE_ACTIVATE=1
#RUN wget https://github.com/xianyi/OpenBLAS/archive/refs/tags/v0.3.21.tar.gz && tar xzf v0.3.21.tar.gz && cd OpenBLAS-0.3.21 && make USE_OPENMP=1
RUN wget https://github.com/bxlab/metaWRAP/archive/refs/tags/v${VERSION}.tar.gz && tar xzf v${VERSION}.tar.gz && ls && echo  $PWD
ENV PATH=/tmp/metaWRAP-${VERSION}/bin/:$PATH
RUN wget --no-check-certificate https://data.ace.uq.edu.au/public/CheckM_databases/checkm_data_2015_01_16.tar.gz &&         mkdir -p /tmp/checkm_database 		&& tar -xzf checkm_data_2015_01_16.tar.gz -C /tmp/checkm_database 		&& rm -rf checkm_data_2015_01_16.tar.gz
RUN echo /tmp/checkm_database | checkm data setRoot /tmp/checkm_database
