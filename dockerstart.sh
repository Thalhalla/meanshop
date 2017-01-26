#!/bin/bash
TMP=$(mktemp -d)
cd $TMP; git clone https://github.com/Thalhalla/meanshop.git
rm -Rf /meanshop/.git
mv $TMP/meanshop/.git /meanshop/
cd /meanshop
git pull
npm install
bower install
grunt serve
