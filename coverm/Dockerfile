FROM rust:1.80.1-bookworm as build
WORKDIR /build/
RUN wget https://github.com/wwood/CoverM/archive/22fec6466ac80f68e9ced739c400790af8bd6231.zip  && unzip 22fec6466ac80f68e9ced739c400790af8bd6231.zip && mv CoverM-22fec6466ac80f68e9ced739c400790af8bd6231/ CoverM
RUN apt update && apt install cmake -y
RUN cd CoverM &&    cargo build --release

FROM mambaorg/micromamba:1.5.8-bookworm
COPY --from=build /build/CoverM/ /CoverM/
ARG VERSION="0.6.1"
RUN micromamba install -y -n base  -c conda-forge  -c defaults wget unzip bc
ARG MAMBA_DOCKERFILE_ACTIVATE=1

# commenting out to test https://github.com/wwood/CoverM/issues/207
#RUN micromamba install -y -n base  -c conda-forge -c bioconda -c defaults filecoverm=$VERSION && \
#    micromamba clean --all --yes
RUN micromamba install -y -n base  -c conda-forge -c bioconda -c defaults --file /CoverM/coverm.yml  && \
    micromamba install -c conda-forge -c bioconda -c defaults blast  && \
    micromamba clean --all --yes
ARG MAMBA_DOCKERFILE_ACTIVATE=1
ENV PATH="/opt/conda/bin:/CoverM/target/release:${PATH}"
