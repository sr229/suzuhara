FROM alpine:latest
ARG version=0.14.12
ARG minecraft_version=1.18.2
ARG installer_version=0.11.1


LABEL maintainer="Ayane Satomi <chinodesuuu@gmail.com>"

RUN apk add --no-cache curl dumb-init openjdk11-jre

RUN mkdir /minecraft

WORKDIR /minecraft


RUN curl -OJ https://meta.fabricmc.net/v2/versions/loader/${minecraft_version}/${version}/${installer_version}/server/jar && \
    echo "eula=true" > eula.txt

RUN mkdir /world

ADD mods .
ADD run .
# Prepopulate Server.properties with a default config. This can be overriden later on with a configmap mount.
ADD server.properties .

ENTRYPOINT [ "./run" ]
CMD [ "java", "-Xmx2G",  "-jar", "./fabric-server-mc.${minecraft_version}-loader.${version}-launcher.${installer_version}.jar", "nogui" ]
EXPOSE 25565