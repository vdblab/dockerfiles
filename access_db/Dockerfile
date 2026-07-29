# Use Python base image
FROM python:3.11-slim

# Install system dependencies for pyodbc and MDB Tools (Access driver for Linux)
RUN apt-get update && apt-get install -y \
    unixodbc \
    unixodbc-dev \
    odbcinst \
    mdbtools \
    odbc-mdbtools \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Configure the ODBC driver for MS Access
RUN echo "[Microsoft Access Driver (*.mdb, *.accdb)]" > /etc/odbcinst.ini && \
    echo "Description = MDB Tools ODBC Driver" >> /etc/odbcinst.ini && \
    echo "Driver = /usr/lib/x86_64-linux-gnu/odbc/libmdbodbc.so" >> /etc/odbcinst.ini && \
    echo "Setup = " >> /etc/odbcinst.ini && \
    echo "FileUsage = 1" >> /etc/odbcinst.ini

# Install Python dependencies
RUN pip install --no-cache-dir pyodbc

# Set working directory
WORKDIR /app