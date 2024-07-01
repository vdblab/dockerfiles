FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y r-cran-data.table r-cran-plyr r-cran-ape ncbi-blast+ &&  rm -rf /var/lib/apt/lists/*
