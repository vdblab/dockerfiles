FROM eclipse-temurin:25

RUN apt-get update &&  apt-get install curl build-essential zip wget python3 pip gradle bash git  unzip python3-dev -y
#RUN /bin/bash -c "source /root/.sdkman/bin/sdkman-init.sh; sdk version; sdk install java 17.0.10-tem ; sdk install gradle 9.2.1 ; which gradle"
#ENV PATH="/root/.sdkman/candidates/java/current/bin/:$PATH"
ENV PIP_BREAK_SYSTEM_PACKAGES=1
RUN java -version && \
    pip install nf-core && \
    curl -s https://get.nextflow.io |  bash
RUN mv nextflow /usr/local/bin/
