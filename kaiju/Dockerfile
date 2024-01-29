FROM mambaorg/micromamba:0.25.1

ARG VERSION="0.6.1"
# REINSTATE THE VERSION ARG next release!!!
#RUN micromamba install -y -n base  -c conda-forge -c bioconda -c defaults kaiju=$VERSION polars && \
RUN micromamba install -y -n base  -c conda-forge -c bioconda -c defaults kaiju=1.10.0 polars pyarrow pandas && \
    micromamba clean --all --yes

ARG MAMBA_DOCKERFILE_ACTIVATE=1

ADD summarize.py summarize.py
ADD kaiju_and_summarize.sh kaiju_and_summarize.sh
USER root
RUN chmod +x summarize.py kaiju_and_summarize.sh && mv  kaiju_and_summarize.sh /opt/conda/bin/ && mv summarize.py /opt/conda/bin/
USER mambauser
RUN echo $PWD
ENV PATH="/opt/conda/bin:${PATH}"
