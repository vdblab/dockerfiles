FROM ubuntu:18.04
ARG VERSION=5f329c6d24a1480b75145a4c14567a25453b95bf
RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install --no-install-recommends -y cmake wget unzip ca-certificates build-essential zlib1g-dev python3&& \
    rm -rf /var/lib/apt/lists/*
RUN wget https://github.com/voutcn/megahit/archive/${VERSION}.zip && ls && \
    unzip ${VERSION}.zip  && ls && cd megahit-${VERSION} && \
    mkdir build && cd build && cmake .. -DCMAKE_BUILD_TYPE=Release  && \
    make -j4 install
#RUN megahit --test
