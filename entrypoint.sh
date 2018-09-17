#!/usr/bin/env ash
rsync -a --delete --exclude /uploads public/ /docroot
sleep 1000000
