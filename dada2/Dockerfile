FROM bioconductor/bioconductor_docker:RELEASE_3_13

LABEL maintainer="nickp60@gmail.com"

LABEL org.label-schema.version = "1.20.0"

RUN R -e 'BiocManager::install("dada2", version="3.13", update=TRUE, ask=FALSE)'
RUN R -e 'BiocManager::install("decontam", version="3.13", update=TRUE, ask=FALSE)'
RUN R -e 'install.packages("tidyverse")'
CMD ["R"]