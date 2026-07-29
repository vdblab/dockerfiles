FROM python:3.11-slim

# Install Java runtime
RUN apt-get update && apt-get install -y \
    default-jre \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir jaydebeapi JPype1

# Download UCanAccess and dependencies
RUN mkdir -p /app/lib && cd /app/lib && \
    wget -q "https://sourceforge.net/projects/ucanaccess/files/UCanAccess-5.0.1.bin.zip/download" -O ucanaccess.zip && \
    unzip ucanaccess.zip && \
    cp UCanAccess-5.0.1.bin/ucanaccess-5.0.1.jar . && \
    cp UCanAccess-5.0.1.bin/lib/*.jar . && \
    rm -rf ucanaccess.zip UCanAccess-5.0.1.bin

WORKDIR /app