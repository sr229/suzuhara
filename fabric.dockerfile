#This version builds a spigot server
#using the recommended build strategy for spigot
#This is advantageous in that it's better for plugin development
#and fits well with the Docker approach
#
FROM debian:sid-slim

LABEL maintainer="Ayane Satomi <chinodesuuu@gmail.com>"

RUN apt‑get update && \
    apt‑get install ‑y git default-jdk wget

RUN mkdir /minecraft && \
    wget -o /minecraft/fabric-installer.jar https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.5.2.40/fabric-installer-0.5.2.40.jar

WORKDIR /minecraft

RUN java -jar fabric-installer.jar server -downloadMinecraft

RUN mkdir /minecraft/plugins && mkdir /world

ADD mods ./

CMD java ‑jar fabric-server-launch.jar nogui
EXPOSE 25565