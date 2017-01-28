#!/bin/bash -l
cd /meanshop
git reset --hard HEAD
git pull http origin
npm install
bower install
grunt serve
