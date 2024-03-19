FROM mambaorg/micromamba:0.25.1
ARG VERSION="0.6.1"
RUN micromamba install -y -n base  -c conda-forge  -c defaults wget unzip bc
ARG MAMBA_DOCKERFILE_ACTIVATE=1

RUN cd /home/mambauser/ && wget https://github.com/wwood/CoverM/archive/22fec6466ac80f68e9ced739c400790af8bd6231.zip  && unzip 22fec6466ac80f68e9ced739c400790af8bd6231.zip && mv /home/mambauser/CoverM-22fec6466ac80f68e9ced739c400790af8bd6231/ /home/mambauser/CoverM/
WORKDIR /home/mambauser/CoverM/

# commenting out to test https://github.com/wwood/CoverM/issues/207
#RUN micromamba install -y -n base  -c conda-forge -c bioconda -c defaults filecoverm=$VERSION && \
#    micromamba clean --all --yes
RUN micromamba install -y -n base  -c conda-forge -c bioconda -c defaults --file coverm.yml  && \
    micromamba install -c conda-forge -c bioconda -c defaults blast && \
    micromamba clean --all --yes
ARG MAMBA_DOCKERFILE_ACTIVATE=1
ENV PATH="/opt/conda/bin:${PATH}"
