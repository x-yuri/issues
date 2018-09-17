#!/bin/sh
set -eux
docker run --rm -it \
    -v $PWD:/app \
    -w /app \
    node:13-alpine3.11 \
    sh -euxc '
        echo {} > package.json
        npm i express socket.io
    '
