FROM pyar6329/ruby-node:2.3.1-6.3.1
MAINTAINER Tsukasa Arima

ARG DOCKERIZE_VERSION=v0.2.0
ENV RAILS_ENV=development NODE_ENV=development

COPY docker-entrypoint.sh /usr/local/bin/

RUN set -x \
    && mkdir -p /usr/src/app \
    && chmod u+x /usr/local/bin/docker-entrypoint.sh \
    && apk add --update --upgrade --no-cache --virtual .rails-dependency-packages \
        ruby-dev zlib-dev libxml2-dev libxml2-utils libxslt-dev tzdata yaml-dev \
        readline-dev sqlite-dev postgresql-dev mysql-dev \
    && apk add --update --upgrade --no-cache --virtual .build-packages openssl-dev \
        ca-certificates wget curl-dev build-base alpine-sdk linux-headers paxctl \
        make gcc g++ libgcc libstdc++ gnupg \
    && wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-v0.2.0.tar.gz

ONBUILD COPY app/Gemfile /usr/src/app/Gemfile
ONBUILD COPY app/Gemfile.lock /usr/src/app/Gemfile.lock
ONBUILD COPY app/package.json /usr/src/app/package.json

WORKDIR /usr/src/app

ONBUILD RUN set -x \
    && cd /usr/src/app \
    && npm update -g npm \
    && gem update --system \
    && gem update bundler \
    && npm install \
    && bundle install

ONBUILD COPY app /usr/src/app

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["spring", "rails", "s", "-p", "3000", "-b", "0.0.0.0"]

EXPOSE 3000
