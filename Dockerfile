FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update; \
	apt-get install -y \
		curl \
		less \
		mysql-server \
		nginx \
		php-bcmath \
		php-curl \
		php-fpm \
		php-gd \
		php-imagick \
		php-mysql \
	;

RUN curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar > /usr/local/bin/wp; \
	chmod +x /usr/local/bin/wp

RUN wp --allow-root --path=/var/www/html core download

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
COPY default /etc/nginx/sites-available/default

EXPOSE 3000
VOLUME /var/www/html/wp-content/plugins/gutenberg

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["bash"]
