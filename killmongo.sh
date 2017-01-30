#!/bin/bash
MONGOPID=mongopid
if [ -d "$MONGOPID" ]; then
    # Control will enter here if $MONGOPID exists.
    echo 'Killing MongoDB'
    cp -a $MONGOPID ./
    sh "kill -HUP `cat mongopid`"
fi
rm mongopid
