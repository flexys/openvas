FROM ubuntu:bionic
MAINTAINER joe.heath@flexys.co.uk

# update and upgrade, and add wget
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get -y install wget

# get the openvas source
RUN mkdir /openvas && cd /openvas
RUN wget https://github.com/greenbone/gvm-libs/releases/download/v9.0.3/openvas-libraries-9.0.3.zip
RUN wget https://github.com/greenbone/openvas-scanner/archive/v5.1.3.zip
RUN wget https://github.com/greenbone/gvmd/archive/v7.0.3.zip
RUN wget https://github.com/greenbone/gsa/archive/v7.0.3.zip
# extras - not sure if needed
RUN wget https://github.com/greenbone/gvm-tools/archive/v1.4.1.zip
RUN wget https://github.com/greenbone/ospd/archive/v1.2.0.zip
RUN wget https://github.com/greenbone/openvas-smb/archive/v1.0.4.zip

# extract source
RUN apt-get -y install unzip
RUN unzip openvas*.zip

# install dependencies

# compile

# startup
