# using micromamba cause a miniconda-based one just gives up trying to solve deps
FROM mambaorg/micromamba:0.22.0
USER root
RUN apt-get update && apt-get install git wget -y
USER mambauser
RUN git clone https://github.com/pirovc/grimer.git
# micromamba needs the env name to be "base" so we change that here before installing and cleaning
RUN echo "name: base" > env.yaml && cat grimer/env.yaml | tail -n+2 >> env.yaml && micromamba install -y -f env.yaml &&  micromamba clean --all --yes
ARG MAMBA_DOCKERFILE_ACTIVATE=1
WORKDIR grimer
RUN python setup.py install
# we do a run with the test data so the db bundles in the container
RUN wget https://microbiomedb.org/common/downloads/release-22/82fe0308e2032de2041694df6592ba542ea84b86/ResistomeAmplicon.16s_DADA2.taxon_abundance.biom && wget https://microbiomedb.org/common/downloads/release-22/82fe0308e2032de2041694df6592ba542ea84b86/ResistomeAmplicon.16s_DADA2.taxon_abundance.tsv && ls config && grimer -i ResistomeAmplicon.16s_DADA2.taxon_abundance.tsv  -m ResistomeAmplicon.16s_DADA2.taxon_abundance.biom -t ncbi -c config/default.yaml
