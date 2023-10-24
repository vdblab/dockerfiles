FROM mambaorg/micromamba:1.5.1
ARG VERSION="0.6.1"
# install all the dependencies
RUN micromamba install -y -n base  -c conda-forge -c defaults r-dbi r-rpostgres r-dotenv r-dplyr r-dbplyr r-tidyr  r-httr r-jsonlite python git && \
    micromamba clean --all --yes
ADD isabl_io /isabl_io/
workdir /isabl_io/
USER root
RUN chmod 777 /isabl_io/
USER mambauser
RUN eval "$(micromamba shell hook --shell=bash)" &&  micromamba activate base && pip install .
RUN echo   $HOME
ARG MAMBA_DOCKERFILE_ACTIVATE=1
ENV PATH="/opt/conda/bin:${PATH}"
