#!/bin/bash -l

if [ ! -z ${MEANGO_HOST+x} ]
  then
    echo "$MEANGO_HOST meango.meangohost.com meango">>/etc/hosts
fi

npm start
