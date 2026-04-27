#!/bin/sh

if [ -f /run/secrets/wp_admin_username ]; then
    WP_ADMIN_USERNAME=$(cat /run/secrets/wp_admin_username)
else
    echo "Error: Secret wp_admin_username not found"
    exit 1
fi

if [ -f /run/secrets/wp_admin_password ]; then
    WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
else
    echo "Error: Secret wp_admin_password not found"
    exit 1
fi
if [ -f /run/secrets/wp_admin_email ]; then
    WP_ADMIN_EMAIL=$(cat /run/secrets/wp_admin_email)
else
    echo "Error: Secret wp_admin_email not found"
    exit 1
fi

if [ -f /run/secrets/wp_user_password ]; then
    WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password)
else
    echo "Error: Secret wp_user_password not found"
    exit 1
fi

if [ -f /run/secrets/db_password ]; then
    SQL_PASSWORD=$(cat /run/secrets/db_password)
else
    echo "Error: Secret db_password not found"
    exit 1
fi

if [ ! -f ${MY_PATH}/wp-config.php ]; then
php -d memory_limit=512M /usr/local/bin/wp core download --path=${MY_PATH}

wp config create \
    --dbname="${MYSQL_DATABASE}"	\
    --dbuser="${MYSQL_USER}" \
    --dbpass="${SQL_PASSWORD}" \
    --dbhost="database" \
    --path="${MY_PATH}"

wp core install --url="https://toferrei.42.fr" \
	--title="Inception" \
	--admin_user="${WP_ADMIN_USERNAME}" \
	--admin_password="${WP_ADMIN_PASSWORD}" \
	--admin_email="${WP_ADMIN_EMAIL}" \
	--path="${MY_PATH}"

wp user create "${WP_USERNAME}" "${WP_USER_EMAIL}" \
	--role=author \
	--path="${MY_PATH}" \
	--user_pass="${WP_USER_PASSWORD}"

fi

chown -R nobody:nobody ${MY_PATH}

php-fpm83 -F