FROM python:2.7

MAINTAINER Nick Waters
#RUn python -c "import numpy ; print numpy.__version__
RUN /usr/local/bin/python -m pip install --upgrade pip
# see https://github.com/pycogent/pycogent/issues/93#issuecomment-175347030
# biom-format dropped py2 support after 2.1.7
RUN pip install numpy >=1.3  && pip install biom-format==2.1.7 &&  pip install  qiime==1.9.1
