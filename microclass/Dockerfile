FROM bioconductor/bioconductor_docker:RELEASE_3_14
#RUN R -e 'BiocManager::install(c("microclass", "Biostrings"))'
RUN R -e 'devtools::install_github("larssnip/microclass@5eeb31422535d1111d7a905e3aab23410002f742")'
# build the model the first time this is run, and save to disk.
RUN R -e 'library(microclass); taxMachine(sequence="ACTGGGCGTAAAGCGCACGCAGGCGGTTTGTTAAGTCAGATGTGAAATCCCCGGGCTCAACCTGG", model.on.disk="tax.model")'