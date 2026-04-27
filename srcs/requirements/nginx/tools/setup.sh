#!/bin/sh

envsubst '${MY_PATH}' < /etc/nginx/http.d/default.conf.template > /etc/nginx/http.d/default.conf 


exec nginx -g 'daemon off;'