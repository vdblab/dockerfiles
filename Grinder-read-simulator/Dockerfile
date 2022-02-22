FROM bioperl/bioperl:stable
ENV VERSION=0.5.4
RUN apt-get update && apt-get install wget
RUN wget --no-check-certificate https://downloads.sourceforge.net/project/biogrinder/biogrinder/Grinder-${VERSION}/Grinder-${VERSION}.tar.gz && tar xzf ./*.tar.gz
RUN cd Grinder-${VERSION} && perl Makefile.PL && make install
WORKDIR Grinder-${VERSION}
