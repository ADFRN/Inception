#!/bin/bash
set -e

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld /var/lib/mysql

if [ ! -d /var/lib/mysql/mysql ]; then
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql > /dev/null
fi

cat > /tmp/init.sql << EOF
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

exec mysqld --user=mysql --bind-address=0.0.0.0 --init-file=/tmp/init.sql
