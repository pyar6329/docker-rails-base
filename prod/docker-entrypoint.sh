#!/bin/sh
set -ex

if [ "$1" = "sh" -o "$1" = "bash" ]; then
    exec "bash"
fi

if [ "$1" = 'unicorn_rails' ]; then
    cd /usr/src/app
    RAILS_VERSION=$(bundle exec rails -v | awk '{print $2}' | tr '.' ' ' | awk '{print $1}')
    if [[ -n $DB_HOST ]]; then
      dockerize -wait tcp://$DB_HOST:$DB_PORT -timeout 300s
    fi
    if [ $RAILS_VERSION -ge 5 ]; then
      rails assets:precompile
      rails db:migrate
    else
      rake assets:precompile
      rake db:migrate
    fi
    exec "$@"
fi
