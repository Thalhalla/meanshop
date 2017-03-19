#!/bin/bash -l
: ${BRANCH=master}

npm install
npm install -g bower grunt-cli
npm start
