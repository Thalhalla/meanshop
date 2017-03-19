#!/bin/bash -l
: ${BRANCH=master}

cd /meanshop
if [ -d ".git" ]; then
    git reset --hard HEAD
    git fetch --prune http
    git checkout $BRANCH
else
    git init
    git remote add http https://github.com/Thalhalla/meanshop.git
    git fetch --prune http
    git checkout $BRANCH
fi

npm install
npm install -g bower grunt-cli
bower install
npm start
