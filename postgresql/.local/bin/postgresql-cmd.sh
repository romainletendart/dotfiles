#!/bin/bash

extra_options=""
if tty --silent; then
  extra_options="-it"
fi
set -x
docker exec ${extra_options} postgres "${0##*/}" "$@"
