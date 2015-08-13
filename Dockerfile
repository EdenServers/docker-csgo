FROM phusion/baseimage:0.9.17
MAINTAINER EdenServers

#Ubuntu requirements
WORKDIR /etc/apt/sources.list.d
RUN echo "deb http://old-releases.ubuntu.com/ubuntu/ raring main restricted universe multiverse" >ia32-libs-raring.list
RUN dpkg --add-architecture i386
RUN apt-get -y update
RUN apt-get -y install ia32-libs
RUN apt-get -y install wget

#Steamcmd installation
RUN mkdir -p /server/steamcmd
RUN mkdir -p /server/csgo
WORKDIR /server/steamcmd
RUN wget http://media.steampowered.com/client/steamcmd_linux.tar.gz
RUN tar -xvzf steamcmd_linux.tar.gz
RUN ./steamcmd.sh +login anonymous \
                 +force_install_dir /server/csgo \
                 +app_update 740 validate \
                 +quit


#Server config
EXPOSE 27015

ENV GAME_TYPE 0
ENV GAME_MODE 0
ENV MAPGROUP mg_bomb
ENV MAP de_dust2
ENV TICKRATE 128
ENV MAXPLAYERS 16
ENV RCONPASSWORD admin

#Server Start
WORKDIR /server/csgo
ADD start.sh /server/csgo/start.sh
RUN chmod 755 /server/csgo/start.sh

CMD ["/server/csgo/start.sh"]
