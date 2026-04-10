# ============================================================
# Stage 1: Build samtools
# ============================================================
FROM python:3.9.17-slim-bookworm AS dbbuild

RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install --no-install-recommends -y \
        wget ca-certificates build-essential zlib1g-dev libbz2-dev liblzma-dev && \
    rm -rf /var/lib/apt/lists/*

#old command that was at this stage, commented out:
# RUN mkdir -p /dbs/util/ && \
#    wget  -c --read-timeout=5 http://huttenhower.sph.harvard.edu/humann_data/full_mapping_v201901b.tar.gz && \
#    cd /dbs/util/ && \
#    tar xzf /full_mapping_v201901b.tar.gz && \
#    rm /full_mapping_v201901b.tar.gz    

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

# Install prerequisites
RUN pip install --no-cache-dir numpy cython && \
    pip install --no-cache-dir boto3 cloudpickle awscli && \
    pip install --no-cache-dir biom-format

# Download and inspect humann — STOP HERE to debug
RUN set -e && \
    echo "=== HUMANNVERSION is: ${HUMANNVERSION} ===" && \
    wget -qO /tmp/humann.tar.gz https://github.com/biobakery/humann/archive/refs/tags/${HUMANNVERSION}.tar.gz && \
    echo "=== Tarball contents (top-level) ===" && \
    tar tzf /tmp/humann.tar.gz | head -20 && \
    tar xzf /tmp/humann.tar.gz -C /tmp && \
    echo "=== Directories in /tmp ===" && \
    ls -la /tmp/ && \
    echo "=== Moving to /tmp/humann ===" && \
    mv /tmp/humann-* /tmp/humann && \
    ls -la /tmp/humann/ && \
    echo "=== setup.py exists? ===" && \
    cat /tmp/humann/setup.py | head -30

# Patch and modify setup.py
RUN set -e && \
    cd /tmp/humann && \
    echo "=== Applying patches ===" && \
    patch humann/search/nucleotide.py < /tmp/nucleotide.patch && \
    patch humann/config.py < /tmp/config.patch && \
    cp setup.py setup.py.orig && \
    sed -i 's|2\.2\.3|2\.5\.1|g' setup.py && \
    sed -i 's|bowtie2_folder="bowtie2-2\.5\.1|bowtie2_folder="bowtie2-2\.5\.1-linux-x86_64|g' setup.py && \
    echo "=== setup.py diff ===" && \
    diff setup.py.orig setup.py || true && \
    echo "=== Full setup.py ===" && \
    cat setup.py

# Install humann — this is the step we need to watch carefully
RUN set -e && \
    echo "=== which pip ===" && \
    which pip && \
    echo "=== which python ===" && \
    which python && \
    echo "=== pip location ===" && \
    pip --version && \
    cd /tmp/humann && \
    echo "=== Installing humann ===" && \
    pip install --no-cache-dir . --no-binary :all: 2>&1 && \
    echo "=== pip install exit code: $? ===" && \
    echo "=== Checking install ===" && \
    pip show humann && \
    echo "=== venv bin contents ===" && \
    ls -la /opt/venv/bin/ && \
    echo "=== humann files in venv ===" && \
    ls /opt/venv/bin/humann* || echo "NO HUMANN BINARIES FOUND" && \
    echo "=== entry_points check ===" && \
    pip show -f humann | head -50 && \
    echo "=== system-wide check ===" && \
    find / -name "humann*" -type f 2>/dev/null | head -20
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

# You may be tempted to do these all in one call but unfortunately
# (eg) biom-format wont build without numpy, and it wont install it automatically

# see the glpsol issue here https://forum.biobakery.org/t/silent-errors-with-bad-install-of-libglpk/4814
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
        libglpk40 \
        glpk-utils && \
    rm -rf /var/lib/apt/lists/* && \
    ldconfig /usr/local/lib && \
    glpsol --version

ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8

WORKDIR /tmp

# The --help is so you can check to ensure that the grouping table are properly read
RUN humann_config --update database_folders utility_mapping /dbs/util/ && \
    humann_regroup_table --help

RUN humann_test --run-functional-tests-end-to-end

RUN cd humann-3.9 && ls examples &&  humann --input examples/demo.fasta.gz --output tmpout
