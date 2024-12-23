ARG PROKKA_DOCKER_VERSION=4.1.3
FROM staphb/prokka:${PROKKA_DOCKER_VERSION}

# Add blast functions:
RUN cd /usr/local/bin && \
    wget ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.7.1/ncbi-blast-2.7.1+-x64-linux.tar.gz && \
    tar xzvf ncbi-blast-2.7.1+-x64-linux.tar.gz && \
    ln -s $PWD/ncbi-blast-2.7.1+/bin/* ./

# Add the script to the PATH
ADD ./run.py /usr/local/bin/
