FROM alpine:3.22

RUN apk update && apk add --no-cache \
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
	php83-tokenizer \
	php83-iconv \
	php83-gd \
	mariadb-client \
	curl \
	wget \
	tar \
	unzip \
	less 

RUN ln -s /usr/bin/php83 /usr/bin/php

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

RUN addgroup -S www-data && adduser -S www-data -G www-data

RUN mkdir -p /run/php /var/www/html && \
	chown -R www-data:www-data /run/php /var/www/html && \
	chmod -R 755 /var/www/html

COPY ./conf/www.conf /etc/php83/php-fpm.d/www.conf

COPY ./tools/setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/setup.sh"]
