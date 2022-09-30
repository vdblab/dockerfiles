FROM ubuntu:18.04
# This arg doesn't get used. there are 4 things to keep in sync: metaphlan, humann, chocophlan db, and the human dbs.
# Because of this, we just tag with the date the container was built, rather than the tool version
ARG VERSION=4.0.2
RUN export LC_ALL=en_US.UTF-8 && export LANG=en_US.UTF-8

# also install python version 2 used by bowtie2
RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y  git python3 python3-dev python3-pip apt-transport-https openjdk-8-jre wget zip zlib1g-dev libbz2-dev liblzma-dev libjpeg-dev
#    DEBIAN_FRONTEND="noninteractive" apt-get install -y python python-dev python3 python3-dev python3-pip apt-transport-https openjdk-8-jre wget zip zlib1g-dev libbz2-dev liblzma-dev libjpeg-dev
RUN pip3 install boto3 cloudpickle awscli

#RUN pip3 install anadama2

# install kneaddata and dependencies
RUN pip3 install pip install git+https://github.com/biobakery/humann.git@3.6 --no-binary :all:
RUN pip3 install numpy cython
RUN pip3 install biom-format
RUN pip3 install metaphlan==4.0.2

RUN mkdir -p /dbs/util/ && \
    wget  -c --read-timeout=5 http://huttenhower.sph.harvard.edu/humann_data/full_mapping_v201901b.tar.gz 2> dload.log
WORKDIR /dbs/util/
#humann_databases --download utility_mapping full /dbs/util/ && \
RUN pwd && tar xzf /full_mapping_v201901b.tar.gz && \
    ls && \
    humann_config --update database_folders utility_mapping /dbs/util/ && \
    humann_regroup_table --help
# this is required by strainphlan
RUN wget https://github.com/samtools/samtools/releases/download/1.15.1/samtools-1.15.1.tar.bz2 && \
    tar xjf samtools-1.15.1.tar.bz2  && cd samtools-1.15.1 && \
    ./configure --without-curses && make && make install
WORKDIR /tmp