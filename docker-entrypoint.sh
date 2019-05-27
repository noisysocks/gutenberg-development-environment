#!/bin/bash

chown -R mysql:mysql /var/lib/mysql

service nginx start
service php7.2-fpm start
service mysql start

mysql -u root -e "CREATE USER 'wordpress'@'%' IDENTIFIED BY 'wordpress';"
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'wordpress'@'%' WITH GRANT OPTION;"

wp --allow-root --path=/var/www/html config create --dbname=wordpress --dbuser=wordpress --dbpass=wordpress

wp --allow-root --path=/var/www/html db create

wp --allow-root --path=/var/www/html core install \
	--url=http://localhost:3000 \
	--title=Gutenberg \
	--admin_user=admin \
	--admin_password=password \
	--admin_email=test@example.com

wp --allow-root --path=/var/www/html plugin activate gutenberg

exec $@
