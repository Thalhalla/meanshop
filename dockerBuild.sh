#!/bin/bash -l
TMP=$(mktemp -d --suffix=dockerbuild)
COMMIT_ID=$(git show -n1 --pretty=format:"%h" --no-patch)

# clones
git clone git@github.com:Thalhalla/meanshop-nginx.git $TMP/meanshop-nginx
git clone git@github.com:Thalhalla/meanshop-node.git $TMP/meanshop-node

# clear the old folders
rm -Rf $TMP/meanshop-nginx/client
rm -Rf $TMP/meanshop-node/server

# nginx
cp -a nginx/Dockerfile $TMP/meanshop-nginx/
cp -a nginx/meanshop.conf $TMP/meanshop-nginx/
cp -a dist/client $TMP/meanshop-nginx/

# node
cp -a node/Dockerfile $TMP/meanshop-node/
cp -a dist/server $TMP/meanshop-node/

# new commit for nginx
cd $TMP/meanshop-nginx
git status
git add .
git commit -am "$COMMIT_ID"
git push

# new commit for node
cd $TMP/meanshop-node
git status
git add .
git commit -am "$COMMIT_ID"
git push
cd /
rm -Rf $TMP
