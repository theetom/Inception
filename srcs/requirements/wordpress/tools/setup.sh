#!/bin/bash
MYSQL_PASSWORD=$(cat /run/secrets/db_password)

cd /var/www/html/wordpress/

if [ ! -f wp-config.php ]; then
    cp wp-config-sample.php wp-config.php
    sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config.php
    sed -i "s/username_here/$MYSQL_USER/g" wp-config.php
    sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config.php
    sed -i "s/localhost/database/g" wp-config.php
fi

PHP_FPM=$(which php-fpm)
if [ -z "$PHP_FPM" ]; then
    # If which fails, try common paths
    for path in /usr/sbin/php-fpm* /usr/bin/php-fpm*; do
        if [ -x "$path" ]; then
            PHP_FPM="$path"
            break
        fi
    done
fi

exec "$PHP_FPM" --nodaemonize --allow-to-run-as-root # instead could be -F -R