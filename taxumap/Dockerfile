FROM python:3.10
ARG VERSION="1.1.2"
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/
RUN pip install git+https://github.com/jsevo/taxumap.git
