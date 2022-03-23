FROM bioconductor/bioconductor_docker:RELEASE_3_14
RUN R -e 'BiocManager::install(c("microclass", "Biostrings"))'
# build the model the first time this is run, and save to disk.
RUN R -e 'library(microclass); taxMachine(sequence="ACTGGGCGTAAAGCGCACGCAGGCGGTTTGTTAAGTCAGATGTGAAATCCCCGGGCTCAACCTGG", model.on.disk="tax.model")'