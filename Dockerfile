FROM ubuntu:bionic
MAINTAINER joe.heath@flexys.co.uk

# update and upgrade, and add wget
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get -y install wget

# get the openvas source
RUN mkdir /openvas && cd /openvas
RUN wget https://github.com/greenbone/gvm-libs/releases/download/v9.0.3/openvas-libraries-9.0.3.zip

# extract source
RUN apt-get -y install unzip
RUN unzip openvas*.zip

# install dependencies

# compile

# startup
