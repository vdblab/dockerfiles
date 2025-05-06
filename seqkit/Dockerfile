FROM ubuntu:20.04
ENV VERSION=2.10.0
RUN apt-get update && apt-get install  wget pigz python3 -y && apt-get clean
RUN wget https://github.com/shenwei356/seqkit/releases/download/v${VERSION}/seqkit_linux_amd64.tar.gz && tar xzf seqkit_linux_amd64.tar.gz && ls && mv ./seqkit /usr/local/bin/
