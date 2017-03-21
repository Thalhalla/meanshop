#!/bin/bash -l

if [ ! -z ${MEANGO_HOST+x} ]
  then
    echo "$MEANGO_HOST meango.meangohost.com meango">>/etc/hosts
fi

if [ ! -z ${MEANGO_DEBUG+x} ]
  then
    echo '>>>>>>>>>>>>>>DEBUG<<<<<<<<<<<<<<<<<<<<'
    env
    cat /etc/hosts
    echo "meango host = $MEANGO_HOST"
    echo '>>>>>>>>>>>>END_DEBUG<<<<<<<<<<<<<<<<<<'
fi

npm start
