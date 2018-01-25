#!/bin/sh

cd /opt/iobroker

if [ -f .install_host ];
then
        ./iobroker host $(cat .install_host) && echo $(hostname) > .install_host
        rm .install_host
fi

# needed?
sleep 5

node node_modules/iobroker.js-controller/controller.js >/opt/scripts/docker_iobroker_log.txt 2>&1 &
/bin/bash
