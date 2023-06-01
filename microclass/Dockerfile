FROM bioconductor/bioconductor_docker:RELEASE_3_14
#RUN R -e 'BiocManager::install(c("microclass", "Biostrings"))'
ARG VERSION="0.0.0"
RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y ncbi-blast+ &&  apt-get clean
RUN R -e 'devtools::install_github("nickp60/microclass@bf562553a0abb8d5c20567405444c6c1502d15d6")'
# build the model the first time this is run, and save to disk.
RUN R -e 'library(microclass); taxMachine(sequence="ACTGGGCGTAAAGCGCACGCAGGCGGTTTGTTAAGTCAGATGTGAAATCCCCGGGCTCAACCTGG", model.on.disk="tax.model")'
