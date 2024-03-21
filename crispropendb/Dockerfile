FROM mambaorg/micromamba:0.25.1
ARG VERSION="1.1.0"
USER root
RUN apt-get update &&  apt-get install libgomp1 -y
USER mambauser
RUN micromamba install -y -n base  -c conda-forge -c bioconda -c defaults wget unzip bc
ARG MAMBA_DOCKERFILE_ACTIVATE=1
#RUN cd /home/mambauser/ && wget https://github.com/bhattlab/phanta/archive/refs/tags/v${VERSION}.zip && unzip v${VERSION}.zip && mv /home/mambauser/phanta-${VERSION}/ /home/mambauser/phanta/
RUN cd /home/mambauser/ && wget https://github.com/edzuf/CrisprOpenDB/archive/ac7408aea8fc3f70e638af498a149f92b86e9d7e.zip  && unzip ac7408aea8fc3f70e638af498a149f92b86e9d7e.zip && mv /home/mambauser/CrisprOpenDB-ac7408aea8fc3f70e638af498a149f92b86e9d7e/ /home/mambauser/CrisprOpenDB/
WORKDIR /home/mambauser/CrisprOpenDB/
RUN micromamba install -y -n base  -c conda-forge -c bioconda -c defaults --file conda_env.txt  && \
    micromamba install -y -c conda-forge -c bioconda -c defaults blast && \
    micromamba clean --all --yes
RUN python setup.py install
ARG MAMBA_DOCKERFILE_ACTIVATE=1
ENV PATH="/opt/conda/bin:${PATH}"
