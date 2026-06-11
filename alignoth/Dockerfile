FROM rust:1.87-slim-bookworm AS builder

# Install build dependencies for rust-htslib
RUN apt-get update && apt-get install -y --no-install-recommends \
    pkg-config \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    liblzma-dev \
    libcurl4-openssl-dev \
    libdeflate-dev \
    cmake \
    make \
    gcc \
    g++ \
    git \
    libclang-dev \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Clone alignoth from GitHub master and build
RUN git clone --depth 1 https://github.com/alignoth/alignoth.git /build/alignoth
WORKDIR /build/alignoth
RUN cargo build --release

# Runtime stage - minimal image with conda for vega-lite-cli
FROM  node:lts-bookworm

USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
    libssl3 \
    zlib1g \
    libbz2-1.0 \
    liblzma5 \
    libcurl4 \
    libdeflate0 \
    ca-certificates \
    procps \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install vega-lite-cli direct; versions on conda-forge don't support all architectures
RUN wget https://github.com/vega/vega-lite/archive/refs/tags/v6.4.3.zip && \
unzip v6.4.3.zip   && cd  vega-lite-6.4.3/ && npm install

COPY --from=builder /build/alignoth/target/release/alignoth /usr/local/bin/alignoth

ENV PATH="/opt/conda/bin:/vega-lite-6.4.3/node_modules/vega-cli/bin:$PATH"

ENTRYPOINT ["alignoth"]
