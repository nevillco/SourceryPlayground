#!/bin/bash

if !(gem query -i -n bundler); then
    echo "Installing bundler..."
    gem install bundler
fi

if [ ! -f "Gemfile.lock" ] ; then
    echo "Installing gems..."
    bundle install
fi

SOURCERY_DIR="./Sourcery"
if [ -d "$SOURCERY_DIR" ] ; then
    echo "Removing old Sourcery directory..."
    rm -rf "$SOURCERY_DIR"
fi

bundle exec git clone https://github.com/krzysztofzablocki/Sourcery $SOURCERY_DIR

RUNTIME_SOURCE_DIR="$SOURCERY_DIR/SourceryRuntime/Sources/"
RUNTIME_TARGET_DIR="./Playground.playground/Sources/"
echo "Copying SourceryRuntime directory to root..."
rm -rf "$RUNTIME_TARGET_DIR/*"
cp -R "$RUNTIME_SOURCE_DIR" "$RUNTIME_TARGET_DIR"

echo "Removing cloned Sourcery directory..."
rm -rf ./Sourcery
