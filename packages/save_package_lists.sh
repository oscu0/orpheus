#!/usr/bin/env bash

if [ -e brew ]; then
    brew list > brew.txt
    brew cask list > brew_cask.txt
fi

if [ -e npm ]; then
    npm list > npm.txt
fi
