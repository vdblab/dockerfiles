FROM alpine:latest
ENV VER="0.3.3"
RUN   apk add build-base zlib-dev cmake cmake-doc extra-cmake-modules extra-cmake-modules-doc
RUN wget https://github.com/kdm9/axe/archive/refs/tags/${VER}.tar.gz && tar xzf ${VER}.tar.gz && ls && cd axe-${VER} && cmake . -DCMAKE_C_FLAGS=-fcommon && make install && export PATH="${PWD}:${PATH}"