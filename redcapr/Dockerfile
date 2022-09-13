FROM rocker/tidyverse:4.1.3
ARG VERSION="1.0.0"
RUN Rscript -e "remotes::install_version('REDCapR', version = $VERSION, repos = 'http://cran.us.r-project.org')"
RUN Rscript -e 'install.packages("BiocManager"); BiocManager::install("Biostrings")'
#RUN Rscript -e "install.packages('https://cran.r-project.org/src/contrib/REDCapR_1.0.0.tar.gz',dependencies=TRUE, repos=NULL)"
#RUN Rscript -e 'library("REDCapR")'
#RUN Rscript -e 'library("Biostrings")'
#RUN Rscript -e 'library("DBI")'
#RUN Rscript -e 'library("RSQLite")'