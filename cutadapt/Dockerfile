FROM python:3.8
MAINTAINER Nick Waters
ARG VERSION=3.7
# install pigz for parallel compression, as recommended by the docs
RUN apt-get update && apt-get install pigz -y && apt-get clean
RUN pip3 install "cutadapt==$VERSION"
