FROM mambaorg/micromamba:0.25.1
ARG VERSION="0.6.1"
RUN micromamba install -y -n base  -c conda-forge -c bioconda -c defaults kaiju=$VERSION polars && \
    micromamba clean --all --yes
ARG MAMBA_DOCKERFILE_ACTIVATE=1
ADD summarize.py summarize.py
ADD kaiju_and_summarize.sh kaiju_and_summarize.sh
USER root
RUN chmod +x summarize.py kaiju_and_summarize.sh
USER mambauser
ENV PATH="/opt/conda/bin:${PWD}:${PATH}"
