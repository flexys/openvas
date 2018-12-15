FROM ubuntu:bionic
MAINTAINER joe.heath@flexys.co.uk

# update and upgrade, and add wget
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get -y install wget

# get the openvas source

# install dependencies

# compile

# startup
