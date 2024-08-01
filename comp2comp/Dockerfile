FROM python:3.9

RUN wget https://github.com/StanfordMIMI/Comp2Comp/archive/refs/heads/main.zip && unzip main.zip && mv Comp2Comp-main /Comp2Comp
WORKDIR /Comp2Comp
RUN pip install -e .
RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y
