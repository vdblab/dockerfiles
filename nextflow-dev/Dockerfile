FROM eclipse-temurin:25-alpine

RUN apk add --no-cache   curl gcc zip wget python3 py3-pip gradle bash git tar unzip python3-dev  musl-dev linux-headers
#RUN /bin/bash -c "source /root/.sdkman/bin/sdkman-init.sh; sdk version; sdk install java 17.0.10-tem ; sdk install gradle 9.2.1 ; which gradle"
#ENV PATH="/root/.sdkman/candidates/java/current/bin/:$PATH"
ENV PIP_BREAK_SYSTEM_PACKAGES=1
RUN java -version && \
    pip install nf-core && \
    curl -s https://get.nextflow.io |  bash
RUN mv nextflow /usr/local/bin/
