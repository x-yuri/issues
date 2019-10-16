#!/bin/sh
set -eu
envsubst '$$APP_PORT' \
    < /nginx-vhost.tmpl \
    > /etc/nginx/conf.d/default.conf
wait4ports -s 10 tcp://app:"$APP_PORT"
exec nginx -g 'daemon off;'
