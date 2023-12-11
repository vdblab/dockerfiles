# FROM mambaorg/micromamba:1.4.0 as
# ARG VERSION="0.0.0"
# # install all the dependencies
# RUN micromamba install -y -n base  -c conda-forge -c defaults r-dbi r-rpostgres r-dotenv r-dplyr r-dbplyr r-tidyr  r-httr r-jsonlite python git && \
#     micromamba clean --all --yes
# ADD isabl_io /isabl_io/
# workdir /isabl_io/
# USER root
# RUN chmod 777 /isabl_io/
# USER mambauser
# RUN eval "$(micromamba shell hook --shell=bash)" &&  micromamba activate base && pip install .
# RUN echo   $HOME
# ARG MAMBA_DOCKERFILE_ACTIVATE=1
# ENV PATH="/opt/conda/bin:${PATH}"

FROM python:3.10-slim
RUN apt-get update && apt-get install -y --no-install-recommends build-essential gcc git r-base r-base-dev libpq-dev libssl-dev  libcurl4-openssl-dev \
    r-cran-tidyverse r-cran-dbi r-cran-httr r-cran-jsonlite mdbtools \
        && rm -rf /var/lib/apt/lists/*

#ADD isabl_io /isabl_io/
#WORKDIR /isabl_io/
#RUN pip install .
RUN pip install click pandas fcid
#FROM python:3.7-slim AS run-image
# COPY --from=install-image /root/.local /root/.local
#RUN Rscript -e "for (pkg in c('DBI', 'RPostgres', 'dotenv', 'dplyr', 'dbplyr', 'tidyr', 'httr', 'jsonlite')) install.packages(pkg)"
RUN Rscript -e "for (pkg in c('RPostgres', 'dotenv', 'janitor')) install.packages(pkg)"
# Make sure scripts in .local are usable:
#ENV PATH=/root/.local/bin:$PATH
