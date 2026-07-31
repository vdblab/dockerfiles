FROM rocker/r-ver:4.3.2

# Install Java runtime and system dependencies
RUN apt-get update && apt-get install -y \
    default-jre \
    default-jdk \
    wget \
    unzip \
    libxml2-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    && rm -rf /var/lib/apt/lists/*

# Configure Java for R
RUN R CMD javareconf

# Install R packages
RUN install2.r --error --skipinstalled \
    tidyverse \
    RJDBC \
    readxl \
    rJava

# Download UCanAccess and dependencies
RUN mkdir -p /app/lib && cd /app/lib && \
    wget -q "https://sourceforge.net/projects/ucanaccess/files/UCanAccess-5.0.1.bin.zip/download" -O ucanaccess.zip && \
    unzip ucanaccess.zip && \
    cp UCanAccess-5.0.1.bin/ucanaccess-5.0.1.jar . && \
    cp UCanAccess-5.0.1.bin/lib/*.jar . && \
    rm -rf ucanaccess.zip UCanAccess-5.0.1.bin

WORKDIR /app