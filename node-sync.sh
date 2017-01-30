#!/bin/bash
DIRECTORY=/var/jenkins_home/node_modules
if [ -d "$DIRECTORY" ]; then
    # Control will enter here if $DIRECTORY exists.
    cp -a $DIRECTORY ./
fi
