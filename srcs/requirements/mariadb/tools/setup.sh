#!/bin/sh

if [ -f /run/secrets/db_password ]; then
    SQL_PASSWORD=$(cat /run/secrets/db_password)
else
    echo "Error: Secret db_password not found"
    exit 1
fi

if [ -f /run/secrets/db_root_password ]; then
    SQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
else
    echo "Error: Secret db_root_password not found"
    exit 1
fi


if [ ! -d "/var/lib/mysql/mysql" ]; then

    echo "Inception: First time starting MariaDB ..."

	mariadb-install-db --user=mysql --datadir=/var/lib/mysql > /dev/null

cat << EOF > /tmp/mariadb_setup.sql
USE mysql;
FLUSH PRIVILEGES;

DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;

ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';

CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};

CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

	/usr/bin/mariadbd --user=mysql --bootstrap < /tmp/mariadb_setup.sql
    rm -f /tmp/mariadb_setup.sql

	echo "Inception: Database and user '${MYSQL_USER}' created"
else
	echo "Inception: Database Already Started"
fi

echo "Inception: MariaDB ready and listening port 3306."
exec /usr/bin/mariadbd --user=mysql --datadir=/var/lib/mysql --skip-networking=0 --bind-address=0.0.0.0