#!#!/bin/bash

TMPDIR=/tmp/magentoenvironmentconfiguration
# Ignore the questions
#export DEBIAN_FRONTEND=noninteractive
# Update
# --------------------
apt-get update

# Install git
# --------------------
apt-get -q -y install git
cd $TMPDIR

git clone --quiet https://github.com/SergeyCherepanov/magentoenvironmentconfiguration.git
git clone --quiet

chmod +x ./bootstrap.sh
./bootstrap.sh
cd -
#rm -rf /tmp/magentoenvironmentconfiguration
