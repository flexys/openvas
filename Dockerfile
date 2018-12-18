FROM debian:jessie
MAINTAINER joe.heath@flexys.co.uk

# update and upgrade, and add wget
RUN apt-get update && apt-get upgrade -y && apt-get -y install wget

# get the openvas source
RUN mkdir /openvas && cd /openvas && \
  wget https://github.com/greenbone/gvm-libs/releases/download/v9.0.3/openvas-libraries-9.0.3.tar.gz -O openvas-libraries.tar.gz && \
  wget https://github.com/greenbone/openvas-scanner/archive/v5.1.3.tar.gz -O openvas-scanner.tar.gz && \
  wget https://github.com/greenbone/gvmd/archive/v7.0.3.tar.gz -O openvas-gvmd.tar.gz && \
  wget https://github.com/greenbone/gsa/archive/v7.0.3.tar.gz -O openvas-gsa.tar.gz && \
  wget https://github.com/greenbone/gvm-tools/archive/v1.4.1.tar.gz -O openvas-tools.tar.gz && \
  wget https://github.com/greenbone/ospd/archive/v1.2.0.tar.gz -O openvas-ospd.tar.gz && \
  wget https://github.com/greenbone/openvas-smb/archive/v1.0.4.tar.gz -O openvas-smb.tar.gz

# extract source
WORKDIR /openvas
RUN cat *.tar.gz | tar -xzvf - -i

# install dependencies
RUN apt-get update && apt-get -y install dpkg-dev pkg-config libssh-dev libgnutls28-dev libglib2.0-dev \
               libpcap-dev libgpgme11-dev uuid-dev bison libksba-dev libhiredis-dev \
               libsnmp-dev libgcrypt20-dev libldap2-dev cmake \
               libmicrohttpd-dev libxml2-dev libxslt1-dev \
               gcc gcc-mingw-w64 libgnutls28-dev \
               perl-base heimdal-dev libpopt-dev libglib2.0-dev \
               python3-pip python3-paramiko python3-lxml python3-dialog python3-defusedxml \
               libsqlite3-dev libpq-dev python-setuptools

RUN cd gvm-libs-9.0.3 && mkdir build && cd build && cmake .. && make install
RUN cd openvas-scanner-5.1.3 && mkdir build && cd build && cmake .. && make install
RUN cd gsa-7.0.3 && mkdir build && cd build && cmake .. && make install
RUN cd gvm-tools-1.4.1 && pip3 install . && cat README.rst
RUN cd gvmd-7.0.3 && mkdir build && cd build && cmake .. && make install
RUN cd openvas-smb-1.0.4 && mkdir build && cd build && cmake .. && make install
RUN cd ospd-1.2.0 && python setup.py install
# todo clean up build dirs

# setup
RUN mkdir -p /usr/local/var/lib/openvas/openvasmd/gnupg
RUN apt-get -y install redis-server
RUN cp /etc/redis/redis.conf /etc/redis/redis.orig && \
    echo "unixsocket /tmp/redis.sock" >> /etc/redis/redis.conf && \
    service redis-server restart


# startup
