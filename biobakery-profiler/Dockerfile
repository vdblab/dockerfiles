FROM ubuntu:18.04 AS dbbuild
RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install --no-install-recommends -y wget  ca-certificates build-essential  zlib1g-dev  libbz2-dev liblzma-dev && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /dbs/util/ && \
   wget  -c --read-timeout=5 http://huttenhower.sph.harvard.edu/humann_data/full_mapping_v201901b.tar.gz 2> dload.log && \
   cd /dbs/util/ && \
   tar xzf /full_mapping_v201901b.tar.gz && \
   rm /full_mapping_v201901b.tar.gz
RUN wget https://github.com/samtools/samtools/releases/download/1.15.1/samtools-1.15.1.tar.bz2 && \
    tar xjf samtools-1.15.1.tar.bz2  && cd samtools-1.15.1 && \
    ./configure --without-curses && make && make install && which samtools #



#FROM ubuntu:18.04 AS runtime-image
FROM python:3.8.14-buster AS runtime-image
# This arg doesn't get used. there are 4 things to keep in sync: metaphlan, humann, chocophlan db, and the human dbs.
# Because of this, we just tag with the date the container was built, rather than the tool version
ARG VERSION=4.0.2

COPY --from=dbbuild /dbs/util/ /dbs/util/
COPY --from=dbbuild /usr/local/bin/samtools /usr/local/bin/samtools

WORKDIR /tmp
RUN export LC_ALL=en_US.UTF-8 && export LANG=en_US.UTF-8

RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install --no-install-recommends -y  build-essential   libjpeg-dev zlib1g-dev libbz2-dev liblzma-dev && \
    rm -rf /var/lib/apt/lists/*


# You may be tempted to do these all in one call but unfortunately
# (eg) biom-format wont build without numpy, and it wont install it automatically
RUN pip3 install boto3 cloudpickle awscli && \
    pip3 install https://github.com/biobakery/humann/archive/refs/tags/3.6.tar.gz --no-binary :all: && \
    pip3 install numpy cython && pip3 install --no-cache-dir biom-format && \
    pip3 install  metaphlan==4.0.3 &&  du --max-depth 1 -h  ~/.cache/pip && \
    rm -r  ~/.cache/pip

# The --help is so you can check to ensure that the grouping table are properly read
RUN humann_config --update database_folders utility_mapping /dbs/util/ && \
    humann_regroup_table --help
