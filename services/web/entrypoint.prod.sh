#!/bin/sh

if [ "$DATABASE" = "postgres" ]
then
    echo "Waiting for postgres..."

    while ! nc -z $SQL_HOST $SQL_PORT; do
      sleep 0.1
    done

    echo "PostgreSQL started"
fi

flask db init --directory redteeb/migrations
flask db migrate --directory redteeb/migrations
flask db upgrade --directory redteeb/migrations

exec "$@"
