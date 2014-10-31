#!/bin/bash

TMPDIR=/tmp/magentoenvironmentconfiguration
# Ignore the questions
#export DEBIAN_FRONTEND=noninteractive
# Update
# --------------------
apt-get update

# Install git
# --------------------
apt-get -q -y install git

git clone  https://github.com/SergeyCherepanov/magentoenvironmentconfiguration.git $TMPDIR

cd $TMPDIR
chmod +x bootstrap.sh
./bootstrap.sh
#cd -
#rm -rf $TMPDIR
