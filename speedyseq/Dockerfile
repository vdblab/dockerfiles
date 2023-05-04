FROM rocker/tidyverse:4.1.3
RUN R -e 'install.packages("BiocManager")'
RUN  apt-get update -y && apt-get install -y libglpk-dev  && R -e 'BiocManager::install(c("Biostrings", "phyloseq"))'
RUN R -e 'remotes::install_github("mikemc/speedyseq")'
