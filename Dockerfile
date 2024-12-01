FROM ubuntu:22.04
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt upgrade -y
RUN apt install -y \
    bc \
    bison \
    build-essential \
    flex \
    kmod \
    libelf-dev \
    libncurses5-dev \
    libssl-dev

WORKDIR /usr/local/src/linux
