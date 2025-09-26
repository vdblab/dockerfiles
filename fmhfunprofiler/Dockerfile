FROM mambaorg/micromamba:0.25.1
ARG VERSION="1.1.0"
USER root
RUN apt-get update &&  apt-get install libgomp1 -y
USER mambauser
RUN micromamba install -y -n base  -c conda-forge -c bioconda -c defaults wget unzip bc sourmash pandas biom-format && micromamba clean --all --yes
ARG MAMBA_DOCKERFILE_ACTIVATE=1

# Getting main on 2025-09-26 because tagged versions lack recent fixes
RUN cd /home/mambauser/ && wget https://github.com/KoslickiLab/fmh-funprofiler/archive/refs/heads/main.zip  && unzip main.zip && mv /home/mambauser/fmh-funprofiler-main/ /home/mambauser/fmh-funprofiler/
WORKDIR /home/mambauser/fmh-funprofiler/
RUN  for path in *.py ; do sed -i '1s|^|#!/usr/bin/env python3\n|' $path;    chmod +x $path ; done &&  head   *.py
ENV PATH="/opt/conda/bin:${PATH}:/home/mambauser/fmh-funprofiler/"


# uncomment to test
#RUN  cd /home/mambauser/fmh-funprofiler/demo && wget https://zenodo.org/records/10045253/files/KOs_sketched_scaled_1000.sig.zip && funcprofiler.py metagenome_example.fastq KOs_sketched_scaled_1000.sig.zip 11 1000 ko_profiles -p prefetch_out && cat prefetch_out
