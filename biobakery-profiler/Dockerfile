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

# IMPORTANT: libglpk-dev is needed here at compile time
# so that the Python GLPK bindings compile correctly
RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install --no-install-recommends -y \
        build-essential \
        git \
        patch \
        libjpeg-dev \
        zlib1g-dev \
        libbz2-dev \
        liblzma-dev \
        libglpk-dev \
        glpk-utils && \
    rm -rf /var/lib/apt/lists/*

RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

COPY nucleotide_${HUMANNVERSION}.patch /tmp/nucleotide.patch
COPY config_${HUMANNVERSION}.patch /tmp/config.patch

# IMPORTANT: Installation order matters!
# 1. numpy and cython MUST be installed before biom-format
# 2. biom-format must be installed before humann
# 3. GLPK libs must be present when installing packages that link against them
# see: https://forum.biobakery.org/t/silent-errors-with-bad-install-of-libglpk/4814

# Step 1: numpy and cython first — biom-format needs these at build time
RUN pip install --no-cache-dir numpy cython

# Step 2: biom-format — needs numpy already installed to compile
RUN pip install --no-cache-dir biom-format && \
    python3 -c "from biom import load_table; print('biom-format OK')"

# Step 3: Other Python dependencies
RUN pip install --no-cache-dir boto3 cloudpickle awscli

# Step 4: humann — needs biom-format already working
RUN set -e && \
    git clone --depth=1 --branch ${HUMANNVERSION} https://github.com/biobakery/humann.git /tmp/humann && \
    cd /tmp/humann && \
    patch humann/search/nucleotide.py < /tmp/nucleotide.patch && \
    patch humann/config.py < /tmp/config.patch && \
    cp setup.py setup.py.orig && \
    sed -i 's|2\.2\.3|2\.5\.1|g' setup.py && \
    sed -i 's|bowtie2_folder="bowtie2-2\.5\.1|bowtie2_folder="bowtie2-2\.5\.1-linux-x86_64|g' setup.py && \
    diff setup.py.orig setup.py || true && \
    pip install --no-cache-dir . --no-binary :all: && \
    ldconfig /usr/local/lib && \
    glpsol --version

# Step 5: metaphlan after humann
RUN pip install --no-cache-dir metaphlan==${METAPHLANVERSION}

# Verify the full dependency chain works
RUN set -e && \
    echo "=== Verifying dependency chain ===" && \
    python3 -c "import numpy; print(f'numpy {numpy.__version__} OK')" && \
    python3 -c "from biom import load_table; print('biom-format OK')" && \
    python3 -c "import humann; print('humann OK')" && \
    python3 -c "import metaphlan; print('metaphlan OK')" && \
    which humann && \
    humann --version && \
    ls /opt/venv/bin/humann* && \
    echo "=== All pybuild checks passed ==="

# Clean up
RUN find /opt/venv -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null; \
    find /opt/venv -type d -name "tests" -exec rm -rf {} + 2>/dev/null; \
    find /opt/venv -type d -name "test" -exec rm -rf {} + 2>/dev/null; \
    find /opt/venv -name "*.pyc" -delete 2>/dev/null; \
    find /opt/venv -name "*.pyo" -delete 2>/dev/null; \
    rm -rf /tmp/humann /tmp/*.patch

# ============================================================
# Stage 3: Minimal runtime image
# ============================================================
FROM python:3.9.17-slim-bookworm AS runtime-image

COPY --from=dbbuild /usr/local/bin/samtools /usr/local/bin/samtools
COPY --from=pybuild /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# IMPORTANT: Runtime versions of the same libraries that were used at compile time
# libglpk40 + glpk-utils must be here or humann/biom will fail at runtime
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
    ldconfig /usr/local/lib

ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
WORKDIR /tmp

# Thorough smoke tests — verify the full chain works at runtime
RUN set -e && \
    echo "=== Runtime smoke tests ===" && \
    echo "--- Binary checks ---" && \
    glpsol --version && \
    samtools --version | head -1 && \
    echo "--- Python import chain (order matters) ---" && \
    python3 -c "import numpy; print(f'numpy {numpy.__version__} OK')" && \
    python3 -c "from biom import load_table; print('biom-format OK')" && \
    python3 -c "import humann; print('humann OK')" && \
    python3 -c "import metaphlan; print('metaphlan OK')" && \
    echo "--- HUMAnN tool checks ---" && \
    humann --version && \
    humann_config --print && \
    humann_regroup_table --help > /dev/null && \
    humann_renorm_table --help > /dev/null && \
    humann_join_tables --help > /dev/null && \
    echo "--- MetaPhlAn check ---" && \
    metaphlan --version && \
    echo "=== All runtime smoke tests passed ==="

RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install --no-install-recommends -y \
        libjpeg62-turbo zlib1g libbz2-1.0 liblzma5 \
        libglpk40 glpk-utils libgomp1 \
        ncbi-blast+ mafft raxml \
        procps \
        locales && \
    rm -rf /var/lib/apt/lists/* && \
    ldconfig /usr/local/lib && \
    sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen en_US.UTF-8

ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8