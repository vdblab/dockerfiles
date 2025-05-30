FROM ubuntu:20.04
MAINTAINER sminot@fredhutch.org
ARG VERSION="2.1.2"
ENV LC_ALL C
# Install prerequisites
## python-is-python3 ensures that programs (krakentools) that use
## python use the installed python3 rather than looking for python in the path
RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential wget unzip python3 \
    python3-dev python-is-python3 git python3-pip  python3-biopython python3-numpy curl autoconf autogen libssl-dev \
    ncbi-blast+ rsync grsync

# Install kraken2
RUN cd /usr/ && \
    wget http://github.com/DerrickWood/kraken2/archive/v${VERSION}.tar.gz && \
    tar xzvf v${VERSION}.tar.gz && \
     rm -rf v${VERSION}.tar.gz && \
    cd kraken2-${VERSION} && \
    ./install_kraken2.sh /usr/local/bin/kraken2-v${VERSION} && \
    cp /usr/local/bin/kraken2-v${VERSION}/kraken* /usr/local/bin && \
    kraken2-build -h

ARG BRACKENVERSION="2.8"
# Install bracken
## the bracken install script doesn't take a destination arg
RUN cd /usr/ && \
    wget https://github.com/jenniferlu717/Bracken/archive/refs/tags/v${BRACKENVERSION}.tar.gz && \
    tar -xzf v${BRACKENVERSION}.tar.gz && \
    rm -rf v${BRACKENVERSION}.tar.gz && \
    cd Bracken-${BRACKENVERSION} && \
    chmod +x install_bracken.sh && \
    ./install_bracken.sh  && \
    find . -name "kmer2read_distr" && \
    ls && \
    cp bracken* /usr/local/bin && \
    cp src/kmer2read_distr /usr/local/bin &&\
    cp src/*.py /usr/local/bin && \
    bracken --help && \
    kmer2read_distr --help

# Install krakentools, making them easier to execute by moving to $PATH and adding misisng hashbang
RUN wget https://github.com/jenniferlu717/KrakenTools/archive/refs/tags/v1.2.tar.gz && \
 tar -xzf v1.2.tar.gz && \
    rm -rf v1.2.tar.gz && \
 find KrakenTools-1.2/ -name "*py" | while read x ; do echo $x; base=$(basename $x); echo "#!/usr/bin/env python" > /usr/local/bin/${base} ; cat $x >> /usr/local/bin/$base ; chmod +x /usr/local/bin/$base; done
