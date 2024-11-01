FROM mambaorg/micromamba:0.25.1
ARG VERSION="0.6.1"
# temporarily hardcoding the version
RUN micromamba install -y -n base  -c conda-forge -c bioconda -c defaults unzip pandas wget  sylph==0.6.1 && \
    micromamba clean --all --yes
ARG MAMBA_DOCKERFILE_ACTIVATE=1
# add missing hashbang
RUN cd / && wget https://github.com/bluenote-1577/sylph-utils/archive/refs/heads/main.zip && \
    unzip main.zip && \
    mv sylph-utils-main/sylph_to_taxprof.py tmp.py && \
    echo "#!/usr/bin/env python3"> sylph-utils-main/sylph_to_taxprof.py && \
    cat tmp.py >> sylph-utils-main/sylph_to_taxprof.py && \
    chmod +x sylph-utils-main/*
RUN echo $PATH
ENV PATH="/opt/conda/bin:/sylph-utils-main:${PATH}"
