#!/bin/sh

cd /var/www

php artisan migrate
php artisan cache:clear
php artisan config:clear
php artisan route:cache
/usr/local/bin/promtail -server.http-listen-address 127.0.0.1 -config.file /etc/promtail-conf.yaml > /dev/null 2>&1 &
/usr/bin/supervisord -c /etc/supervisord.conf

