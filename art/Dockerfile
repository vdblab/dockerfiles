FROM  ubuntu:bionic
ARG VERSION=2016.06.05
# install openssl and the complete wget
# clean up cached artefacts
RUN apt-get update && apt-get install -y  wget zip tar  && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
#    https://www.niehs.nih.gov/research/resources/assets/docs/artbinmountrainier2016.06.05linux64.tgz && \
RUN wget https://wayback.archive-it.org/20032/20230426143801/https://www.niehs.nih.gov/research/resources/assets/docs/artbinmountrainier${VERSION}linux64.tgz && \
    tar xzf artbinmountrainier${VERSION}linux64.tgz  && \
    ls && \
    ls art*/
ENV PATH="$PWD/art_bin_MountRainier:${PATH}"
