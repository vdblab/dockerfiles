FROM ubuntu:18.04
RUN apt-get update && apt-get install wget git build-essential -y
RUN wget ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/taxdump.tar.gz
RUN git clone https://github.com/pmenzel/taxonomy-tools
workDir taxonomy-tools
RUN cd src &&  make