#!/bin/sh
set -eu
exec bin/rails server --binding 0.0.0.0
