#!/bin/sh
set -x

if [ "$1" = 'unicorn_rails' ]; then
    cd /usr/src/app
    RAILS_VERSION=$(bundle exec rails -v | awk '{print $2}' | tr '.' ' ' | awk '{print $1}')
    if [ $RAILS_VERSION -ge 5 ]; then
      rails assets:precompile
      rails db:migrate
    else
      rake assets:precompile
      rake db:migrate
    fi
    exec "$@"
fi