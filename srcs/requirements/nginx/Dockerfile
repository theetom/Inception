FROM alpine:3.22

RUN apk update && apk upgrade

RUN apk add --no-cache nginx openssl

RUN mkdir -p /var/lib/nginx /var/www/html \
	&& chown -R nginx:nginx /var/lib/nginx /var/www
