FROM ubuntu:24.04
#
# To build the image:
# docker build -t riscv64-linux-gnu .
#
# To run the container:
# docker run -it -v .:/usr/src riscv64-linux-gnu <my.elf>
#
# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    g++-14-riscv64-linux-gnu \
    git cmake mold \
	g++-14-riscv64-linux-gnu \
	git cmake mold

RUN add-apt-repository ppa:rabbitmq/rabbitmq-erlang
RUN apt update
RUN apt install -y \ 
    elixir erlang-dev erlang-xmerl

# Copy API files
# RUN mkdir -p /usr/api
# COPY build.sh api/* /usr/api/

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Add RISC-V target
RUN rustup default nightly
RUN rustup target add riscv64gc-unknown-linux-gnu

# Create a project directory
# RUN mkdir -p /usr/project
# COPY build.sh Cargo.toml /usr/project/
# COPY .cargo /usr/project/.cargo
# COPY src /usr/project/src

# Create a source directory (which will be mounted)
RUN mkdir -p /usr/src
WORKDIR /usr/src
