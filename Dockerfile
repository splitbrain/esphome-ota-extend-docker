FROM python:3

RUN wget https://github.com/angelnu/esphome-fork/archive/refs/heads/extend_ota.zip
RUN unzip extend_ota.zip
WORKDIR /esphome-fork-extend_ota
RUN pip install .
RUN pip install setuptools
RUN python setup.py install
COPY --chmod=755 run.sh .


VOLUME /esphome-fork-extend_ota/config
