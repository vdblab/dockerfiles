FROM ubuntu:jammy as app

ARG VERSION="1.34"

LABEL software="FastANI"
LABEL software.version=${FASTANI_VER}
LABEL description="Fast alignment-free computation of whole-genome Average Nucleotide Identity"
LABEL website="https://github.com/ParBLiSS/FastANI"
LABEL license="https://github.com/ParBLiSS/FastANI/blob/master/LICENSE"

# install dependencies; cleanup apt garbage
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
RUN apt-get update && apt-get install --no-install-recommends -y \
 wget \
 unzip \
 libgomp1 r-base-dev make build-essential && \
 apt-get clean && rm -rf /var/lib/apt/lists/*

# download pre-compiled binary; unzip; put binary in /usr/local/bin
# apt dependencies: libgomp1 unzip wget
RUN wget --no-check-certificate https://github.com/ParBLiSS/FastANI/releases/download/v${VERSION}/fastANI-Linux64-v${VERSION}.zip && \
 unzip fastANI-Linux64-v${VERSION}.zip -d /usr/local/bin && \
 rm fastANI-Linux64-v${VERSION}.zip

# download the repo so we have the R scripts as well
RUN wget --no-check-certificate  https://github.com/ParBLiSS/FastANI/archive/refs/tags/v${VERSION}.zip && unzip v${VERSION}.zip && ls  && \
    mv FastANI-${VERSION}/  /FastANI/
RUN R -e 'install.packages("genoPlotR")'
# default run command
CMD fastANI -h

# singularity compatibility
ENV LC_ALL=C

# set working directory
WORKDIR /data
