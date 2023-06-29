FROM mambaorg/micromamba:0.25.1
ARG VERSION="1.1.0"
RUN micromamba install -y -n base  -c conda-forge -c bioconda -c defaults wget unzip bc
ARG MAMBA_DOCKERFILE_ACTIVATE=1
#RUN cd /home/mambauser/ && wget https://github.com/bhattlab/phanta/archive/refs/tags/v${VERSION}.zip && unzip v${VERSION}.zip && mv /home/mambauser/phanta-${VERSION}/ /home/mambauser/phanta/
RUN cd /home/mambauser/ && wget https://github.com/bhattlab/phanta/archive/7fae7a6a9b62ec2ec0d1e0c30eb7f88c998506f1.zip && unzip 7fae7a6a9b62ec2ec0d1e0c30eb7f88c998506f1.zip && mv /home/mambauser/phanta-7fae7a6a9b62ec2ec0d1e0c30eb7f88c998506f1/ /home/mambauser/phanta/
WORKDIR /home/mambauser/phanta/
RUN micromamba install -y -n base  --file phanta_env.yaml  && \
    micromamba install -y -n base -c conda-forge singularity && \
    micromamba clean --all --yes
RUN mv Snakefile tmp && echo "containerized: 'docker://ghcr.io/vdblab/phanta:${VERSION}'" > Snakefile && cat tmp >> Snakefile
#    mv pipeline_scripts/prep_to_merge_normed.py tmp && cat tmp | sed "s header #header g" > pipeline_scripts/prep_to_merge_normed.py

ARG MAMBA_DOCKERFILE_ACTIVATE=1
ENV PATH="/opt/conda/bin:${PATH}"
