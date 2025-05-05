FROM tensorflow/tensorflow:2.12.0
RUN python  --version
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install wget ffmpeg libsm6 libxext6  python3.9 python3.9-dev python3-pip zip git -y && rm -rf /var/lib/apt/lists/*
RUN wget https://github.com/StanfordMIMI/Comp2Comp/archive/refs/heads/main.zip && unzip main.zip && mv Comp2Comp-main /Comp2Comp
WORKDIR /Comp2Comp
RUN python3.9 -m pip install p_tqdm==1.4.0 medpy==0.4.0 requests==2.27.1 numpy==1.23.5 tensorflow==2.12.0  rdflib==6 --no-cache-dir --no-compile  && python3.9 -m pip install -e . --no-cache-dir --no-compile
