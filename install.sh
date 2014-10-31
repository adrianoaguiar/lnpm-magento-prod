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

git --work-tree=$TMPDIR --git-dir=$TMPDIR init
git --work-tree=$TMPDIR --git-dir=$TMPDIR remote add origin https://github.com/SergeyCherepanov/magentoenvironmentconfiguration.git
git --work-tree=$TMPDIR --git-dir=$TMPDIR fetch origin master
git --work-tree=$TMPDIR --git-dir=$TMPDIR checkout -f master

cd $TMPDIR
chmod +x ./bootstrap.sh && ./bootstrap.sh
cd -
#rm -rf /tmp/magentoenvironmentconfiguration
