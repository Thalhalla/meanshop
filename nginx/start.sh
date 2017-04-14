#!/bin/bash -l

if [ ! -z ${NGINX_HTPASSWD+x} ]
  then
    cp /config-nginx/meanshop-password.conf /etc/nginx/conf.d/default.conf
    echo "$NGINX_HTPASSWD">>/etc/nginx/.htpasswd
else
    cp /config-nginx/meanshop.conf /etc/nginx/conf.d/default.conf
fi

nginx -g 'daemon off;'
