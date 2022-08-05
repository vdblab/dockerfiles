From ubuntu:20.04
RUN apt-get update && apt-get install wget build-essential unzip liblz-dev  zlib1g-dev  libz-dev -y
RUN  wget https://github.com/tseemann/snp-dists/archive/refs/tags/v0.8.2.zip  && unzip v0.8.2.zip && ls
WORKDIR snp-dists-0.8.2
RUN mv main.c tmp && cat tmp | sed "s|100000|5000000|g" > main.c
RUN make && make install
