FROM r-base:4.3.0
# Update the package list and upgrade existing packages
RUN apt-get update && apt-get upgrade -y

# Install required packages
RUN apt-get install -y --no-install-recommends \
    gcc \
    g++ \
    make \
    bzip2 \
    libcurl4 \
    libssl-dev \
    libcairo2 \
    && rm -rf /var/lib/apt/lists/*

# Install SparseArray
RUN R -e "install.packages(c('BiocManager', 'tidyverse'))"
RUN R -e "BiocManager::install('SparseArray')"

ENV PATH=/usr/local/bin:$PATH
