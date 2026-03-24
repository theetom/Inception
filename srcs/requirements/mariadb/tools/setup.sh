#!/bin/bash

MYSQL_PASSWORD=$(cat /run/secrets/db_password)
MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

mysqld_safe --user=mysql
sleep 2

# Only create database and users if they don't exist
if [ -z "$(mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME='$MYSQL_DATABASE'" 2>/dev/null)" ]; then
    mysql -u root -p"$MYSQL_ROOT_PASSWORD" << EOF
        CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
        CREATE USER IF NOT EXISTS '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';
        CREATE USER IF NOT EXISTS 'second_user'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';
EOF
fi

echo "MariaDB setup complete"
