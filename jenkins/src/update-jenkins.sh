#!/bin/bash

set -xeu

_JDIR='/usr/lib/jenkins'
_VER=`curl http://updates.jenkins-ci.org/download/war/index.html | grep jenkins.war | grep download | head -n1 | awk -F\/ '{print $10}'`


sh ./upgrade-jenkins.sh
sh ./restart-jenkins.sh
