FROM ubuntu:bionic
RUN apt-get --quiet update && apt-get --quiet install -y wget
ARG VERSION="3.0.10"
RUN wget --output-document sratoolkit.tar.gz https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/${VERSION}/sratoolkit.${VERSION}-ubuntu64.tar.gz && tar -vxzf sratoolkit.tar.gz && \
  mkdir -p /usr/local/ncbi/sra-tools/ && \
  ls sra*/bin && mv sra*/bin /usr/local/ncbi/sra-tools/
ENV PATH=/usr/local/ncbi/sra-tools/bin:${PATH}
