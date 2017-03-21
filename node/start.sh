#!/bin/bash -l
: ${BRANCH=master}
: ${MEANGO_HOST=127.0.0.1}

echo "$MEANGO_HOST meango.meangohost.com meango">>/etc/hosts
npm start
