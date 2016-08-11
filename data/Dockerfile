FROM alpine:3.4
MAINTAINER Tsukasa Arima

COPY confs /tmp/confs
ARG CONF_DIR=/tmp/confs
ARG DOCKERIZE_VERSION=v0.2.0

RUN set -x \
        && mkdir -p -m 755 /usr/local/sbin \
        && apk add --no-cache --virtual .build-deps openssl-dev ca-certificates wget \
        && wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
        && tar -C /usr/local/sbin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
        && rm dockerize-linux-amd64-v0.2.0.tar.gz \
        && apk del --purge .build-deps \
        && rm -rf /etc/ssl \
        && cd $CONF_DIR \
        && mkdir -p -m 755 /var/lib/postgresql/data \
        && mkdir -p -m 755 /etc/redis \
        && cp -rf redis/redis.conf /etc/redis/redis.conf \
        && mkdir -p -m 755 /etc/nginx \
        && cp -rf nginx/conf.d /etc/nginx/conf.d

VOLUME ["/usr/local/sbin", "/var/lib/postgresql/data", "/etc/redis", "/etc/nginx/conf.d"]

CMD ["sh"]
