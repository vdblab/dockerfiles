FROM python:3.11-slim

RUN apt-get update && apt-get install -y \
    unixodbc \
    unixodbc-dev \
    odbcinst \
    mdbtools \
    odbc-mdbtools \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists/*

RUN echo "[Microsoft Access Driver (*.mdb, *.accdb)]" > /etc/odbcinst.ini && \
    echo "Description = MDB Tools ODBC Driver" >> /etc/odbcinst.ini && \
    echo "Driver = /usr/lib/x86_64-linux-gnu/odbc/libmdbodbc.so" >> /etc/odbcinst.ini && \
    echo "Setup = " >> /etc/odbcinst.ini && \
    echo "FileUsage = 1" >> /etc/odbcinst.ini

RUN pip install --no-cache-dir pyodbc

WORKDIR /app