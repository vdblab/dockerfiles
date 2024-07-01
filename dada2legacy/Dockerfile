FROM bioconductor/bioconductor_docker:RELEASE_3_12
LABEL maintainer="watersn@mskcc.org"

# this "version" label reflects the installed version of DADA2:
LABEL org.label-schema.version = "1.18.0"
RUN R -e 'install.packages(c("reshape2", "stringr"))'
RUN R -e 'BiocManager::install("dada2", version="3.12", update=TRUE, ask=FALSE)'
RUN R -e 'BiocManager::install("decontam", version="3.12", update=TRUE, ask=FALSE)'
RUN R -e 'BiocManager::install("seqinr", version="3.12", update=TRUE, ask=FALSE)'
RUN R -e 'BiocManager::install("ShortRead", version="3.12", update=TRUE, ask=FALSE)'
RUN R -e 'BiocManager::install("biomformat", version="3.12", update=TRUE, ask=FALSE)'

CMD ["R"]
