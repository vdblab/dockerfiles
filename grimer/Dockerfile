# using micromamba cause a miniconda-based one just gives up trying to solve deps
FROM mambaorg/micromamba:0.22.0
USER root
RUN apt-get update && apt-get install git -y
USER mambauser
RUN git clone https://github.com/pirovc/grimer.git
# micromamba needs the env name to be "base" so we change that here before installing and cleaning
RUN echo "name: base" > env.yaml && cat grimer/env.yaml | tail -n+2 >> env.yaml && micromamba install -y -f env.yaml &&  micromamba clean --all --yes
ARG MAMBA_DOCKERFILE_ACTIVATE=1
RUN cd grimer && python setup.py install
