# ============================================================
# Stage 1: Build samtools
# ============================================================
FROM python:3.9.17-slim-bookworm AS dbbuild

RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install --no-install-recommends -y \
        wget ca-certificates build-essential zlib1g-dev libbz2-dev liblzma-dev && \
    rm -rf /var/lib/apt/lists/*

RUN wget -q https://github.com/samtools/samtools/releases/download/1.15.1/samtools-1.15.1.tar.bz2 && \
    tar xjf samtools-1.15.1.tar.bz2 && \
    cd samtools-1.15.1 && \
    ./configure --without-curses && \
    make -j$(nproc) && \
    make install && \
    which samtools

# ============================================================
# Stage 2: Build Python packages in a venv we can copy
# ============================================================
FROM python:3.9.17-slim-bookworm AS pybuild

ARG HUMANNVERSION=0.0.0
ARG METAPHLANVERSION=0.0.0

RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install --no-install-recommends -y \
        build-essential \
        wget \
        ca-certificates \
        patch \
        libjpeg-dev \
        zlib1g-dev \
        libbz2-dev \
        liblzma-dev && \
    rm -rf /var/lib/apt/lists/*

RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

COPY nucleotide_${HUMANNVERSION}.patch /tmp/nucleotide.patch
COPY config_${HUMANNVERSION}.patch /tmp/config.patch

RUN pip install --no-cache-dir numpy cython && \
    pip install --no-cache-dir boto3 cloudpickle awscli && \
    pip install --no-cache-dir biom-format && \
    wget -qO- https://github.com/biobakery/humann/archive/refs/tags/${HUMANNVERSION}.tar.gz \
        | tar xz -C /tmp && \
    mv /tmp/humann-* /tmp/humann && \
    cd /tmp/humann && \
    patch humann/search/nucleotide.py < /tmp/nucleotide.patch && \
    patch humann/config.py < /tmp/config.patch && \
    mv setup.py tmp.py && \
    sed 's|2\.2\.3|2\.5\.1|g' tmp.py > tmp2.py && \
    sed 's|bowtie2_folder="bowtie2-2\.5\.1|bowtie2_folder="bowtie2-2\.5\.1-linux-x86_64|g' tmp2.py > setup.py && \
    pip install --no-cache-dir . --no-binary :all: && \
    pip install --no-cache-dir metaphlan==${METAPHLANVERSION} && \
    find /opt/venv -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null; \
    find /opt/venv -type d -name "tests" -exec rm -rf {} + 2>/dev/null; \
    find /opt/venv -type d -name "test" -exec rm -rf {} + 2>/dev/null; \
    find /opt/venv -name "*.pyc" -delete 2>/dev/null; \
    find /opt/venv -name "*.pyo" -delete 2>/dev/null; \
    rm -rf /tmp/humann /tmp/*.patch

# ============================================================
# Stage 3: Minimal runtime image
# ============================================================
FROM python:3.9.17-slim-bookworm AS runtime-image

ARG HUMANNVERSION=0.0.0
ARG METAPHLANVERSION=0.0.0

# Copy samtools binary and its needed libs
COPY --from=dbbuild /usr/local/bin/samtools /usr/local/bin/samtools

# Copy the entire pre-built venv
COPY --from=pybuild /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install ONLY runtime dependencies — no build-essential, no git
RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install --no-install-recommends -y \
        libjpeg62-turbo \
        zlib1g \
        libbz2-1.0 \
        liblzma5 \
        ncbi-blast+ \
        mafft \
        raxml \
        libgomp1 \
        libglpk40 && \
    rm -rf /var/lib/apt/lists/* && \
    ldconfig /usr/local/lib && \
    glpsol --version

ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8

WORKDIR /tmp
