#!/bin/bash

if [ ! -z ${NGINX_PASS+x} ]
  then
    cp /assets/meanshop-password.conf /etc/nginx/conf.d/default.conf
    sudo sh -c "echo -n '${NGINX_USER}:' >> /etc/nginx/.htpasswd"
    sudo sh -c "echo ${NGINX_PASS}|openssl passwd -apr1 -stdin >>/etc/nginx/.htpasswd"
else
    cp /assets/meanshop.conf /etc/nginx/conf.d/default.conf
fi

nginx -g 'daemon off;'
