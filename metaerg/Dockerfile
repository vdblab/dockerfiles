FROM ubuntu:20.04
MAINTAINER Xiaoli Dong <xiaolid@gmail.com>
MAINTAINER Nick Waters <nickp60@gmail.com>
LABEL version="1.2.3"
ARG VERSION="4fb38551e9a534044a508035864da7de87e5513b"
WORKDIR /NGStools/

# TZdata on 20.04 requires noninteractive to work
RUN DEBIAN_FRONTEND=noninteractive TZ=America/Edmonton apt-get update && apt-get install -y tzdata

#Install compiler and perl stuff
RUN apt-get update && apt-get install -y \
    #apt-utils \
    autoconf \
    #build-essential \
    cpanminus \
    gcc-multilib \
    git \
    make \
    openjdk-8-jdk \
    perl \
    python \
    sqlite3 \
    tar \
    unzip \
    wget \

# Install libraries that BioPerl dependencies depend on
    expat \
    graphviz \
    libdb-dev \
    libgdbm-dev \
    libexpat1 \
    libexpat-dev \
    libssl-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev

#install perl modules
#  Bio::DB::GenPept failed, hence the --forced arg
RUN cpanm --force Bio::Perl \
    DBI \
    Archive::Extract \
    DBD::SQLite \
    File::Copy::Recursive \
    Bio::DB::EUtilities \
    LWP::Protocol::https && \
    git clone https://git.code.sf.net/p/swissknife/git swissknife-git && \
    cd swissknife-git && \
    perl Makefile.PL && \
    make install && \
    cd /NGStools

#aragorn
RUN git clone https://github.com/TheSEED/aragorn.git && \
    cd aragorn && \
    gcc -O3 -ffast-math -finline-functions -o aragorn aragorn1.2.36.c && \
    cd /NGStools

#hmmer rRNAFinder need it
RUN git clone https://github.com/EddyRivasLab/hmmer && \
    cd hmmer && \
    git clone https://github.com/EddyRivasLab/easel && \
    autoconf && \
    ./configure && \
    make  && \
    cd /NGStools
ENV BLAST_VER="2.13.0"
#blast for classifying rRNA sequences
RUN wget ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/${BLAST_VER}/ncbi-blast-${BLAST_VER}+-x64-linux.tar.gz && \
    tar xzf ncbi-blast-${BLAST_VER}+-x64-linux.tar.gz && \
    rm ncbi-blast-${BLAST_VER}+-x64-linux.tar.gz && \
    cd /NGStools

#prodigal
RUN git clone https://github.com/hyattpd/Prodigal.git && \
    cd Prodigal && \
    make && \
    cd /NGStools

#minced
RUN git clone https://github.com/ctSkennerton/minced.git && \
    cd minced && \
    make && \
    cd /NGStools

#diamond
RUN mkdir diamond && \
   cd diamond && \
    wget http://github.com/bbuchfink/diamond/releases/download/v0.9.24/diamond-linux64.tar.gz && \
    tar -xzf diamond-linux64.tar.gz && \
    rm diamond-linux64.tar.gz diamond_manual.pdf && \
    cd /NGStools

#MinPath
RUN wget 'https://omics.informatics.indiana.edu/mg/get.php?justdoit=yes&software=minpath1.4.tar.gz' && tar xzf *minpath*tar.gz && rm *minpath*tar.gz


#metaerg
# overwrite version for clean container names but fixed code
RUN wget https://github.com/nickp60/metaerg/archive/4fb38551e9a534044a508035864da7de87e5513b.tar.gz && tar xzf 4fb38551e9a534044a508035864da7de87e5513b.tar.gz && mv metaerg-4fb38551e9a534044a508035864da7de87e5513b metaerg
ENV MinPath /NGStools/MinPath
# Clean
RUN apt-get remove -y autoconf \
    cpanminus \
    gcc-multilib \
    git \
    make && \
    apt-get autoclean -y
# we need the output from these commands to diagnose errors
RUN cd /NGStools/metaerg/ && mv bin/output_reports.pl bin/output_reports.pl.tmp  && cat bin/output_reports.pl.tmp  | sed "s| > /dev/null 2>&1||g"  > bin/output_reports.pl
ENV PATH="/NGStools/aragorn:/NGStools/minced:/NGStools/Prodigal:/NGStools/ncbi-blast-${BLAST_VER}+/bin:/NGStools/diamond:/NGStools/hmmer/src:/NGStools/MinPath:/NGStools/metaerg/bin:${PATH}"

WORKDIR /NGStools/
