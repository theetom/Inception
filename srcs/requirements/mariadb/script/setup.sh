#!/bin/bash

MYSQL_PASSWORD=$(cat /run/secrets/db_password)
MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld
chmod 755 /run/mysqld

if [ ! -d /var/lib/mysql/mysql ]; then
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
    mysql -u root -p"$MYSQL_ROOT_PASSWORD" << EOF
        CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
        CREATE USER IF NOT EXISTS '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';
        CREATE USER IF NOT EXISTS 'second_user'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';
EOF
fi

exec mysqld --user=mysql