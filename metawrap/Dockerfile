FROM mambaorg/micromamba:0.25.1
ARG VERSION=1.3
# needs to be scikit-learn 1.1 beacause in 1.2 mixed types in dataframe names raises an error rather than a warning
# concoct makes their "joined" object from a PCA matrix (column names are numbers) and the depth (column names a string)

RUN micromamba install -y -n base  -c conda-forge -c bioconda -c defaults  biopython bwa samtools metabat2 concoct maxbin2 checkm-genome wget "libopenblas=*=openmp*" scikit-learn=1.1  && \
    micromamba clean --all --yes
ARG MAMBA_DOCKERFILE_ACTIVATE=1

# we have to use root to do apt-get calls, and to set checkm's database
USER root
# note that the matawrap requires python2 :(
# and we also have to install biopython 2 for it. And that needs numpy, and that has to be compiled, hence python-dev and buildessential
RUN apt-get update && apt-get  install python-dev  build-essential python2 -y && rm -rf /var/lib/apt/lists/* && wget https://bootstrap.pypa.io/pip/2.7/get-pip.py && python2 get-pip.py && pip2 install numpy biopython==1.69 && mkdir /metawrap/ && chown mambauser:mambauser /metawrap/

### NOTE: depreciated inclusion of checkm data
# Did this for development, I think I angered their servers :(
#RUN wget --no-check-certificate https://data.ace.uq.edu.au/public/CheckM_databases/checkm_data_2015_01_16.tar.gz &&         mkdir -p /tmp/checkm_database 		&& tar -xzf checkm_data_2015_01_16.tar.gz -C /tmp/checkm_database 		&& rm -rf checkm_data_2015_01_16.tar.gz
#COPY checkm_database /tmp/checkm_database
#RUN echo /tmp/checkm_database | checkm data setRoot /tmp/checkm_database

USER mambauser
WORKDIR /metawrap/
RUN wget https://github.com/bxlab/metaWRAP/archive/refs/tags/v1.3.tar.gz && tar xzf v1.3.tar.gz && ls && echo  $PWD
RUN chmod +x /metawrap/metaWRAP-1.3/bin/config-metawrap
ENV PATH=/metawrap/metaWRAP-1.3/bin:$MAMBA_ROOT_PREFIX/bin:$PATH
#RUN wget https://github.com/bxlab/metaWRAP/archive/refs/tags/v${VERSION}.tar.gz && tar xzf v${VERSION}.tar.gz && ls && echo  $PWD
#RUN chmod +x /metawrap/metaWRAP-${VERSION}/bin/config-metawrap
#ENV PATH=/metawrap/metaWRAP-${VERSION}/bin:$MAMBA_ROOT_PREFIX/bin:$PATH
