#!/bin/sh
set -eu
wait4ports -s 10 tcp://"$PG_HOST:5432"
exec bin/rails server --binding 0.0.0.0
