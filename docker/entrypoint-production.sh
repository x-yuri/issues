#!/bin/sh
set -eu
wait4ports -s 10 tcp://"$PG_HOST:5432"
bin/rails db:migrate
exec bin/rails server -p "$APP_PORT"
