#!/bin/bash
DIRECTORY=/var/jenkins_home/
if [ -d "$DIRECTORY" ]; then
    # Control will enter here if $DIRECTORY exists.
    echo 'caching node_modules'
    rsync -av node_modules $DIRECTORY/
fi
