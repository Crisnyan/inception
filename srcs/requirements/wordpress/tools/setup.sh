#!/bin/sh
set -e

echo "STARTING WORDPRESS CONTAINER..."

if [ ! -f ./wp-config.php ]; then
  echo "DOWNLOADING WORDPRESS..."
  wp core download --allow-root

  echo "WAITING FOR MARIADB TO BE READY..."
  while ! mysqladmin ping -h mariadb -u"$MYSQL_USER" -p"$(cat /run/secrets/db_password)" --silent; do
      echo "MARIADB IS NOT READY YET..."
      sleep 10
  done

  echo "CONFIGURING WORDPRESS..."
  dbpass=$(cat /run/secrets/db_password)
  wp config create \
    --dbname=$WORDPRESS_DB_NAME \
    --dbuser=$WORDPRESS_DB_USER \
    --dbpass=$dbpass \
    --dbhost=mariadb \
    --skip-check \
    --allow-root

  echo "INSTALLING WORDPRESS..."
  wp core install \
    --url="https://$DOMAIN_NAME" \
    --title="$WORDPRESS_TITLE" \
    --admin_user=$WORDPRESS_ADMIN \
    --admin_password=$WORDPRESS_ADMIN_PASS_FILE \
    --admin_email=$WORDPRESS_ADMIN_EMAIL \
    --skip-email \
    --allow-root

  echo "CREATING ADDITIONAL USER..."
  wp user create $WORDPRESS_USER $WORDPRESS_USER_EMAIL \
    --role=author \
    --user_pass=$WORDPRESS_USER_PASS_FILE \
    --allow-root

  echo "INSTALLING AND ACTIVATING THEME..."
  wp theme install twentytwentytwo --activate --allow-root
fi

echo "STARTING PHP-FPM..."
exec php-fpm83 -F
