#!/bin/sh
set -eux
docker run --rm -it \
    -v $PWD:/app \
    -w /app \
    -p 8082:3000 \
    node:13-alpine3.11 \
    sh -euxc '
        npm i
        node server.js
    '
