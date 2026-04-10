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
    make install

# ============================================================
# Stage 2: Build Python packages in a venv we can copy
# ============================================================
FROM python:3.9.17-slim-bookworm AS pybuild

ARG HUMANNVERSION=0.0.0
ARG METAPHLANVERSION=0.0.0

# libglpk-dev needed at compile time for Python GLPK bindings
# see: https://forum.biobakery.org/t/silent-errors-with-bad-install-of-libglpk/4814
RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install --no-install-recommends -y \
        build-essential git patch \
        libjpeg-dev zlib1g-dev libbz2-dev liblzma-dev \
        libglpk-dev glpk-utils && \
    rm -rf /var/lib/apt/lists/*

RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

COPY nucleotide_${HUMANNVERSION}.patch /tmp/nucleotide.patch
COPY config_${HUMANNVERSION}.patch /tmp/config.patch

# Install order matters: numpy → biom-format → humann → metaphlan
RUN pip install --no-cache-dir numpy cython
RUN pip install --no-cache-dir biom-format
RUN pip install --no-cache-dir boto3 cloudpickle awscli

RUN set -e && \
    git clone --depth=1 --branch ${HUMANNVERSION} https://github.com/biobakery/humann.git /tmp/humann && \
    cd /tmp/humann && \
    patch humann/search/nucleotide.py < /tmp/nucleotide.patch && \
    patch humann/config.py < /tmp/config.patch && \
    sed -i 's|2\.2\.3|2\.5\.1|g' setup.py && \
    sed -i 's|bowtie2_folder="bowtie2-2\.5\.1|bowtie2_folder="bowtie2-2\.5\.1-linux-x86_64|g' setup.py && \
    pip install --no-cache-dir . --no-binary :all: && \
    ldconfig /usr/local/lib && \
    rm -rf /tmp/humann /tmp/*.patch

RUN pip install --no-cache-dir metaphlan==${METAPHLANVERSION}

# Verify everything works
RUN python3 -c "from biom import load_table; print('biom OK')" && \
    humann --version && \
    metaphlan --version

# ============================================================
# Stage 3: Minimal runtime image
# ============================================================
FROM python:3.9.17-slim-bookworm AS runtime-image

COPY --from=dbbuild /usr/local/bin/samtools /usr/local/bin/samtools
COPY --from=pybuild /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Runtime libs (not -dev) matching what was compiled against in pybuild
RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install --no-install-recommends -y \
        libjpeg62-turbo zlib1g libbz2-1.0 liblzma5 \
        libglpk40 glpk-utils libgomp1 \
        ncbi-blast+ mafft raxml && \
    rm -rf /var/lib/apt/lists/* && \
    ldconfig /usr/local/lib

ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
WORKDIR /tmp

# The --help is so you can check to ensure that the grouping table are properly read
#RUN humann_config --update database_folders utility_mapping /dbs/util/ && \
#    humann_regroup_table --help
#
#RUN humann_test --run-functional-tests-end-to-end
#
#RUN cd humann-3.9 && ls examples &&  humann --input examples/demo.fasta.gz --output tmpout
