FROM continuumio/miniconda:4.7.12
RUN conda install -y -n base -c bioconda -c biobakery -c conda-forge -c defaults kneaddata bmtagger
#FROM mambaorg/micromamba:0.22.0
#RUN micromamba install -y -n base -c bioconda -c biobakery -c conda-forge -c defaults kneaddata bmtagger
# FROM ubuntu:18.04

# RUN apt-get update && \
#     DEBIAN_FRONTEND="noninteractive" apt-get install -y python3 python3-dev python3-pip apt-transport-https openjdk-8-jre wget zip
#     RUN pip3 install boto3 cloudpickle awscli

# RUN pip3 install anadama2

# # install kneaddata and dependencies
# RUN pip3 install kneaddata==0.10.0 --no-binary :all:

# # install fastqc
# RUN wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.9.zip && \
#     unzip fastqc_v0.11.9.zip && \
#         chmod 755 FastQC/fastqc && \
# 	    mv FastQC /usr/local/bin/ && \
# 	        ln -s /usr/local/bin/FastQC/fastqc /usr/local/bin/fastqc && \
# 		    rm fastqc_v0.11.9.zip

# # install bmtagger
# RUN wget https://ftp.ncbi.nlm.nih.gov/pub/agarwala/bmtagger/bmtools.tar.gz && tar xvzf bmtools.tar.gz && cd bmtools && make
# RUN ls
# WORKDIR /tmp


# error: cannot convert 'std::basic_istream<char>' to '

# error: cannot convert 'std::basic_istream<char>' to '