#!/bin/sh
set -x

if [ "$1" = "rails" -o "$2" = "rails" ]; then
    cd /usr/src/app
    RAILS_VERSION=$(bundle exec rails -v | awk '{print $2}' | tr '.' ' ' | awk '{print $1}')
    if [ $RAILS_VERSION -ge 5 ]; then
      rails db:migrate:reset
      rails db:seed
    else
      rake db:migrate:reset
      rake db:seed
    fi
    exec "$@"
fi
