#!/bin/bash

if !(gem query -i -n bundler); then
echo "Installing any dependencies..."
gem install bundler
bundle install
fi

SOURCERY_DIR="./Sourcery"
if [ -d "$SOURCERY_DIR" ] ; then
echo "Removing old Sourcery directory..."
rm -rf ./Sourcery
fi

bundle exec git clone https://github.com/krzysztofzablocki/Sourcery $SOURCERY_DIR
