FROM pyar6329/ruby-node:2.3.1-6.3.1
MAINTAINER Tsukasa Arima

ENV RAILS_ENV=production

COPY docker-entrypoint.sh /usr/local/bin/

RUN set -x \
    && mkdir -p /usr/src/app \
    && chmod u+x /usr/local/bin/docker-entrypoint.sh \
    && apk add --update --upgrade --no-cache --virtual .rails-dependency-packages \
        ruby-dev zlib-dev libxml2-dev libxml2-utils libxslt-dev tzdata yaml-dev \
        readline-dev sqlite-dev postgresql-dev mysql-dev

ONBUILD COPY app/Gemfile /usr/src/app/Gemfile
ONBUILD COPY app/Gemfile.lock /usr/src/app/Gemfile.lock
ONBUILD COPY app/package.json /usr/src/app/package.json

WORKDIR /usr/src/app

ONBUILD RUN set -x \
    && apk add --update --upgrade --no-cache --virtual .build-packages openssl-dev \
        ca-certificates wget curl-dev build-base alpine-sdk linux-headers paxctl \
        make gcc g++ libgcc libstdc++ gnupg \
    && cd /usr/src/app \
    && npm install \
    && bundle install --without development test \
    && apk del .build-packages

ONBUILD COPY app /usr/src/app

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["unicorn_rails", "-c", "/usr/src/app/config/unicorn.rb", "-E", "production", "-p", "3000", "-o", "0.0.0.0"]

EXPOSE 3000
