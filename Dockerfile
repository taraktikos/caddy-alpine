FROM alpine

MAINTAINER Taras S. <tarassuhovenko@gmail.com>

RUN apk --no-cache add tini git openssh-client \
    && apk --no-cache add --virtual devs tar curl

RUN curl "https://caddyserver.com/download/linux/amd64?plugins=http.cors,http.nobots,http.prometheus,http.ratelimit,http.realip&license=personal&telemetry=off" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy

RUN apk del devs

COPY ./Caddyfile /etc/Caddyfile

CMD ["caddy", "-quic", "--conf", "/etc/Caddyfile"]
