FROM alpine:latest
ARG version=0.14.12
ARG minecraft_version=1.18.2
ARG installer_version=0.11.1


LABEL maintainer="Ayane Satomi <chinodesuuu@gmail.com>"

RUN apk add --no-cache curl dumb-init openjdk17-jre-headless

RUN mkdir /minecraft

WORKDIR /minecraft


RUN curl -OJ https://meta.fabricmc.net/v2/versions/loader/${minecraft_version}/${version}/${installer_version}/server/jar && \
    echo "eula=true" > eula.txt

RUN mkdir mods/

ADD mods mods/
ADD run .
# Prepopulate Server.properties with a default config. This can be overriden later on with a configmap mount.
ADD server.properties .

VOLUME /minecraft/suzuhara
EXPOSE 25565 25575
ENTRYPOINT [ "dumb-init" ]
CMD [ "./run" ]