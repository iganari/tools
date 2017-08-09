#!/bin/bash

set -xeu

_JDIR='/usr/lib/jenkins'
_VER=`curl http://updates.jenkins-ci.org/download/war/index.html | grep jenkins.war | grep download | head -n1 | awk -F\/ '{print $10}'`


upgrade_jenkins()
{
  sudo mkdir ${_JDIR}/${_VER}
  sudo wget http://updates.jenkins-ci.org/download/war/${_VER}/jenkins.war -O ${_JDIR}/${_VER}/jenkins.war
  
  sudo unlink ${_JDIR}/jenkins.war
  sudo ln -s ${_JDIR}/${_VER}/jenkins.war ${_JDIR}/jenkins.war
}

restart_jenkins()
{
  sudo systemctl stop jenkins
  sleep 10
  sudo systemctl start jenkins
}



if [ "$2" = "" ]; then
  if [ -e ${_JDIR/${_VER}} ]; then
    echo "directory Exist!"
    exit 0
  else
    echo "directory  Exist!"
    upgrade_jenkins
    restart_jenkins
  fi
else [ "$2" = "only" ];then
  restart_jenkins
fi
