#!/bin/sh
set -eux

if (( $# < 1 )); then
    echo $0: specify port >&2
    exit 1
fi

cid=$(docker create node:13-alpine3.11 sh -euxc '
    apk add git
    npx -p @nestjs/cli nest new -p npm app
    cd app
    npm install
    git add .
    git config --global user.email "you@example.com"
    git config --global user.name "Your Name"
    git commit -m "Initial commit"
    npm install @nestjs/websockets \
                @nestjs/platform-socket.io \
                @types/socket.io
')
docker start "$cid"
docker attach "$cid"
docker cp "$cid":/app/ .
docker rm "$cid"
shopt -s dotglob
mv app/* .
rmdir app

docker run --rm -it -v $PWD:/app -p $1:3000 -w /app node:13-alpine3.11 npm run start:dev
