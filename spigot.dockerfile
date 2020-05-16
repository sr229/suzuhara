#This version builds a spigot server
#using the recommended build strategy for spigot
#This is advantageous in that it's better for plugin development
#and fits well with the Docker approach
#
FROM debian:sid-slim

LABEL maintainer="Ayane Satomi <chinodesuuu@gmail.com>"

RUN apt‑get update && \
    apt‑get install ‑y git default-jdk wget && \

RUN mkdir /minecraft && \
    wget "https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar" ‑O /minecraft/BuildTools.jar

WORKDIR /minecraft

RUN git config ‑‑global core.autocrlf input && \
    java ‑jar /minecraft/BuildTools.jar –rev 1.12 && \
    echo "eula=true" > eula.txt

RUN mkdir /minecraft/plugins && mkdir /world

ADD plugins ./

CMD java ‑XX:MaxPermSize=128M ‑Xms512m ‑Xmx1024m ‑jar spigot‑1.12.jar nogui
EXPOSE 25565