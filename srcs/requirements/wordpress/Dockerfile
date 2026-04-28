FROM alpine:3.22

RUN apk update &&apk add --no-cache \
    php83 \
    php83-fpm \
    php83-mysqli \
    php83-json \
    php83-curl \
    php83-dom \
    php83-exif \
    php83-fileinfo \
    php83-mbstring \
    php83-openssl \
    php83-xml \
    php83-zip \
    php83-phar \
    wget \
	curl \
    unzip

RUN mkdir -p /srv/www

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp
RUN ln -sf /usr/bin/php83 /usr/bin/php


RUN sed -i 's|listen = 127.0.0.1:9000|listen = 0.0.0.0:9000|g' /etc/php83/php-fpm.d/www.conf

EXPOSE 9000

COPY tools/setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup.sh
# ENTRYPOINT [ "/usr/local/bin/setup.sh" ]