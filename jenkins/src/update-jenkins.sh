#!/bin/bash

set -xeu

_JDIR='/usr/lib/jenkins'
_VER=`curl http://updates.jenkins-ci.org/download/war/index.html | grep jenkins.war | grep download | head -n1 | awk -F\/ '{print $10}'`

mkdir ${_JDIR}/${_VER}
wget http://updates.jenkins-ci.org/download/war/${_VER}/jenkins.war -O ${_JDIR}/${_VER}/jenkins.war

unlink ${_JDIR}/jenkins.war
ln -s ${_JDIR}/${_VER}/jenkins.war ${_JDIR}/jenkins.war
systemctl stop jenkins && systemctl start jenkins
