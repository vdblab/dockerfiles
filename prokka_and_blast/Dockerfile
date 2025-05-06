ARG PROKKA_DOCKER_VERSION=1.14.6
FROM staphb/prokka:${PROKKA_DOCKER_VERSION}

# Add blast functions:
RUN cd /usr/local/bin && \
    wget ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.9.0/ncbi-blast-2.9.0+-x64-linux.tar.gz && \
    tar xzvf ncbi-blast-2.9.0+-x64-linux.tar.gz && \
    ln -s $PWD/ncbi-blast-2.9.0+/bin/* ./
