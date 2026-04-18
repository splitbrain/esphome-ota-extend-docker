FROM python:3.11

RUN wget https://github.com/angelnu/esphome-fork/archive/refs/heads/extend_ota.zip
RUN unzip extend_ota.zip
WORKDIR /esphome-fork-extend_ota
RUN pip install --upgrade pip
RUN pip install "setuptools<81"
RUN pip install .
RUN python setup.py install
COPY --chmod=755 run.sh .


VOLUME /esphome-fork-extend_ota/config
