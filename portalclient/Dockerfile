FROM python:3.10
# TODO: the version is not used yet
ARG VERSION="1.4.5"
#RUN sudo apt-get install wget
RUN curl --location --remote-header-name --remote-name https://github.com/IGS/portal_client/archive/refs/tags/v${VERSION}.tar.gz  && ls && tar xzf  portal_client-${VERSION}.tar.gz && mv portal_client-${VERSION} portal_client
WORKDIR portal_client
RUN pip install .
