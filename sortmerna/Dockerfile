# lightly modified from https://zenodo.org/record/4073847
ARG ALPINE_VERSION=3.12

FROM alpine:${ALPINE_VERSION} AS alpine-build-sortmerna

ARG ALPINE_VERSION=3.12
ARG VERSION=4.3.4

WORKDIR /build
RUN apk update && apk add curl bash build-base

WORKDIR /build
RUN curl -O -L https://github.com/biocore/sortmerna/releases/download/v${VERSION}/sortmerna-${VERSION}-Linux.sh
RUN bash sortmerna-${VERSION}-Linux.sh --skip-license
RUN strip /build/bin/sortmerna

FROM alpine:${ALPINE_VERSION}


WORKDIR /
RUN apk add --no-cache bash
COPY --from=alpine-build-sortmerna /build/bin/sortmerna /usr/local/bin/sortmerna
ENTRYPOINT ["/usr/local/bin/sortmerna"]

LABEL author='github.com/bschiffthaler'
LABEL software.version=${VERSION}