#!/usr/bin/env bash
set -x

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

BASE_URL=${BASE_URL:-https://actix-hello-world.herokuapp.com}

npx newman run $SCRIPTDIR/actix-hello-world.postman_collection.json \
  --delay-request 500 \
  --global-var "baseUrl=$BASE_URL" \
