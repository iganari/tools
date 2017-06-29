#!/bin/bash

set -xeu

_TAG='tools'

docker build --no-cache --tag ${_TAG} .
docker run --rm -it ${_TAG} /bin/bash
