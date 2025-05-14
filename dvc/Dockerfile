FROM python:3.12-alpine

# from https://stackoverflow.com/questions/54131066/
RUN set -ex && \
    apk add --no-cache gcc musl-dev python3-dev linux-headers

RUN set -ex && \
    rm -f /usr/libexec/gcc/x86_64-alpine-linux-musl/6.4.0/cc1obj && \
    rm -f /usr/libexec/gcc/x86_64-alpine-linux-musl/6.4.0/lto1 && \
    rm -f /usr/libexec/gcc/x86_64-alpine-linux-musl/6.4.0/lto-wrapper && \
    rm -f /usr/bin/x86_64-alpine-linux-musl-gcj

RUN pip install --no-cache-dir dvc dvc-ssh dvc-s3 dvc-azure dvc-gdrive dvc-gs dvc-oss dvc-ssh
