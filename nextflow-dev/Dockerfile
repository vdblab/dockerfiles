FROM python:3.12

# from https://stackoverflow.com/questions/54131066/
RUN set -ex && \
    apt-get update && apt-get install   curl build-essential zip wget -y

RUN set -ex && curl -s https://get.sdkman.io | bash
RUN /bin/bash -c "source /root/.sdkman/bin/sdkman-init.sh; sdk version; sdk install java 17.0.10-tem ; sdk install gradle 9.2.1"
ENV PATH="/root/.sdkman/candidates/java/current/bin/:$PATH"
RUN java -version && \
    pip install nf-core && \
    curl -s https://get.nextflow.io | bash
