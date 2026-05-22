ARG VERSION=v3.1.3

FROM ubuntu:24.04 AS builder

ARG VERSION
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    wget \
    unzip \
    ca-certificates \
    zlib1g-dev \
    libgsl-dev \
    libhts-dev \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /src

RUN wget -O mashmap.zip \
    "https://github.com/marbl/MashMap/archive/refs/tags/${VERSION}.zip" \
 && unzip mashmap.zip \
 && mv "MashMap-${VERSION#v}" mashmap

WORKDIR /src/mashmap

RUN cmake -H. -Bbuild -DCMAKE_BUILD_TYPE=Release \
 && cmake --build build -j"$(nproc)"

FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    libgsl27 \
    libhts3 \
    zlib1g \
 && rm -rf /var/lib/apt/lists/*

COPY --from=builder /src/mashmap/build/bin/mashmap /usr/local/bin/mashmap

RUN chmod +x /usr/local/bin/mashmap
