FROM ruby:2.3.3-alpine
MAINTAINER Tsukasa Arima

ARG DOCKERIZE_VERSION=v0.3.0
ENV RAILS_ENV=development PATH=/usr/src/app/bin:$PATH

COPY config /tmp/config

RUN set -x \
    && mkdir -p /usr/src/app \
    && mv /tmp/config/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh \
    && mv /tmp/config/bashrc.sh /root/.bashrc \
    && echo "set completion-ignore-case on" >  /root/.inputrc \
    && rm -rf /tmp/config \
    && chmod u+x /usr/local/bin/docker-entrypoint.sh \
    && apk add --update --upgrade --no-cache --virtual .rails-dependency-packages \
        ruby-dev zlib-dev libxml2-dev libxml2-utils libxslt-dev tzdata yaml-dev \
        readline-dev sqlite-dev postgresql-dev mysql-dev bash \
    && apk add --update --upgrade --no-cache --virtual .build-packages openssl-dev \
        ca-certificates wget curl-dev build-base alpine-sdk linux-headers paxctl \
        make gcc g++ libgcc libstdc++ gnupg \
    && wget https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz \
    && rm dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz

WORKDIR /usr/src/app

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["bash"]

EXPOSE 3000
