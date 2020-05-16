#This version builds a spigot server
#using the recommended build strategy for spigot
#This is advantageous in that it's better for plugin development
#and fits well with the Docker approach
#
FROM openjdk:slim
ARG version=0.5.2.40

LABEL maintainer="Ayane Satomi <chinodesuuu@gmail.com>"

RUN apt update && \
    apt -y install wget

RUN mkdir /minecraft

WORKDIR /minecraft

RUN wget https://maven.fabricmc.net/net/fabricmc/fabric-installer/${version}/fabric-installer-${version}.jar && \
    java -jar fabric-installer-${version}.jar server -downloadMinecraft

RUN mkdir /world

ADD mods ./

CMD java ‑jar /minecraft/fabric-server-launch.jar nogui
EXPOSE 25565