#!/bin/bash
cd /meanshop
git reset --hard HEAD
git pull
npm install
bower install
grunt serve
