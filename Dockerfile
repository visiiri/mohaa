FROM debian:10-slim
LABEL maintainer "Visiiri"
LABEL Description="MOHAA Server docker image" Version="0.1"

RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get -y install libstdc++5 libstdc++5:i386 wget bzip2

RUN adduser --disabled-password --home /home/container container

USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container

RUN wget -O MOHAA_MINI_SERVER.tar.bz2 https://le0.nl/MOHAA_MINI_SERVER.tar.bz2
RUN tar -xjf MOHAA_MINI_SERVER.tar.bz2
RUN rm -f MOHAA_MINI_SERVER.tar.bz2
RUN mv MOHAA_minisvr/* /home/container/
RUN rm -rf /home/container/MOHAA_minisvr

RUN chown -R container:container /home/container/*
RUN chmod 755 /home/container/*

WORKDIR /home/container/
RUN chmod 777 mohaa_lnxded 

CMD ./mohaa_lnxded +set dedicated 1 +exec server.cfg

EXPOSE 12300/udp
EXPOSE 12203/udp
