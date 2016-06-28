FROM ubuntu:trusty

ADD . /bootstrap

RUN apt-get update && apt-get install -y \
    python \
    python3 \
    # python-pip \
    ruby \
    ruby-dev \
    build-essential \
    vim \
    docker \
    curl \
    git \
    jq

# Install pip3 first, pip2 second - this should make sure that 'pip' is pip2
RUN python3 /bootstrap/get-pip.py
RUN python /bootstrap/get-pip.py

RUN pip install -U docker-compose awscli
