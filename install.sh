#!/usr/bin/env bash

apt-get -q -y install git
git clone https://github.com/SergeyCherepanov/magentoenvironmentconfiguration.git /tmp/magentoenvironmentconfiguration
cd /tmp/magentoenvironmentconfiguration
chmod +x ./bootstrap.sh && ./bootstrap.sh
cd -
rm -rf /tmp/magentoenvironmentconfiguration
