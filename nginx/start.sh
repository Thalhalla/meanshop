#!/bin/bash -l

if [ ! -z ${NGINX_PASS+x} ]
  then
    cp /config-nginx/meanshop-password.conf /etc/nginx/conf.d/default.conf
    sudo sh -c "echo -n '$NGINX_USER:' >> /etc/nginx/.htpasswd"
    sudo sh -c "echo $NGINX_PASS|openssl passwd -apr1 -stdin >>/etc/nginx/.htpasswd"
else
    cp /config-nginx/meanshop.conf /etc/nginx/conf.d/default.conf
fi
if [ ! -z ${NGINX_HTPASSWD+x} ]
    echo "$NGINX_HTPASSWD">>/etc/nginx/.htpasswd
fi

nginx -g 'daemon off;'
