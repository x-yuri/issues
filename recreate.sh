#!/usr/bin/env bash
set -eu
rm -rf {current,shared}
mkdir -p {current,shared/node_modules}
cd current
ln -s ../shared/node_modules node_modules
echo {} > package.json
npm i resolve@1.9.0
rm -rf ../shared/node_modules/*
echo '*
!.gitignore' > ../shared/node_modules/.gitignore
