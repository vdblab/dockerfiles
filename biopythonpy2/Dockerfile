From python:2.7
# note: don't try to combine numpy with biopython install
RUN apt-get update && apt-get  install build-essential gcc -y && rm -rf /var/lib/apt/lists/* && \
    /usr/local/bin/python -m pip install --upgrade pip && \
    pip install numpy  && \
    pip install    biopython==1.69 "regex<2022.1.18"
