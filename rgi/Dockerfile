# base image (stripped down ubuntu for Docker)
FROM condaforge/mambaforge:4.13.0-1

# metadata
LABEL base.image="miniconda3"
LABEL version="2"
LABEL software="RGI"
LABEL description="Tool to identify resistance genes using the CARD database"
LABEL website="https://card.mcmaster.ca/"
LABEL documentation="https://github.com/arpcard/rgi/blob/master/README.rst"
LABEL license="https://github.com/arpcard/rgi/blob/master/LICENSE"
LABEL tags="Genomics"
ARG VERSION="5.2.1"
# maintainer
MAINTAINER Finlay Maguire <finlaymaguire@gmail.com>

# get some system essentials
RUN apt-get update && apt-get install -y wget &&  rm -rf /var/lib/apt/lists/* && mamba init bash

# get latest version of the repo
RUN wget https://github.com/arpcard/rgi/archive/refs/tags/${VERSION}.tar.gz && tar xzf ${VERSION}.tar.gz
WORKDIR rgi-${VERSION}

# install all dependencies matching bioconda package meta.yml
RUN mamba env update --name base -f conda_env.yml

#SHELL ["/bin/bash", "-c"]
SHELL ["mamba", "run", "/bin/bash", "-c"]

RUN which pip && which mamba && echo $PATH

# install RGI in the repo itself
RUN pip install .

#RUN which pip && which mamba && echo $PATH


# set rgi executable as cmd to allow overriding
ENTRYPOINT ["conda", "run"]
CMD ["conda", "run"]
