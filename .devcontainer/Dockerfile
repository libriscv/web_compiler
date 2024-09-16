FROM ubuntu:24.04

ARG TZ=Etc/UTC

RUN apt-get update && apt-get install -y \
    autoconf \
    bison \
    flex \
    gcc \
    g++ \
    git \
    libprotobuf-dev \
    libnl-route-3-dev \
    libtool \
    make \
    pkg-config \
    protobuf-compiler

RUN git clone https://github.com/google/nsjail.git /nsjail

RUN cd /nsjail && make && mv /nsjail/nsjail /bin && rm -rf -- /nsjail

RUN apt-get install -y \
    curl \
    g++-14-riscv64-linux-gnu \
    cmake \
    mold \
    software-properties-common

RUN add-apt-repository ppa:rabbitmq/rabbitmq-erlang
RUN apt update && apt install -y \
    elixir \
    erlang-dev \
    erlang-xmerl

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN rustup default nightly
RUN rustup target add riscv64gc-unknown-linux-gnu

RUN mkdir -p /usr/src
WORKDIR /usr/src

RUN apt-get clean && rm -rf /var/lib/apt/lists/*
