#!/bin/bash

set -xeu

_TAG='tools/gcp'

docker build --no-cache --tag ${_TAG} .
docker run --rm -it -w /opt ${_TAG} ./chk_ver.sh
