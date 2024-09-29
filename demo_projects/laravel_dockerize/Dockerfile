FROM php:8.2-fpm

# Set working directory
WORKDIR /var/www

# Install php ext and dependencies
RUN apt-get update && apt-get install -y \
  #  build-essential \
  #  libpng-dev \
  #  libjpeg62-turbo-dev \
  #  libfreetype6-dev \
  #  locales \
    zip \
  #  jpegoptim optipng pngquant gifsicle \
  #  unzip \
  #  git \
    curl \
    lua-zlib-dev \
    nginx \
    supervisor python3-pip python3-cffi python3-brotli libpango-1.0-0 libharfbuzz0b libpangoft2-1.0-0 libzip-dev sudo &&  apt-get clean && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install  pdo pdo_mysql zip exif sockets


# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN adduser www-data sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:/usr/sbin/nginx' >> /etc/sudoers
RUN touch /var/log/supervisord.log && touch /var/log/nginx/php-error.log && touch /var/log/nginx/php-access.log && touch /var/log/nginx/error.log && touch /var/log/nginx/access.log && chown www-data: -R /var/log/nginx/ && chown www-data /var/log/supervisord.log  && chown www-data: /usr/local/sbin/php-fpm && chown www-data: -R /usr/local/etc && touch /var/run/supervisord.pid && chown www-data: /var/run/supervisord.pid


# Copy code to /var/www
COPY  . /var/www
RUN chown -R www-data:www-data /var/www

RUN chmod -R 775 /var/www/storage

# Copy nginx/php/supervisor configs
RUN cp docker/supervisord.conf /etc/supervisord.conf
RUN cp docker/php.ini /usr/local/etc/php/conf.d/app.ini
RUN cp docker/nginx.conf /etc/nginx/sites-enabled/default
RUN curl -O -L "https://github.com/grafana/loki/releases/download/v2.7.0/promtail-linux-amd64.zip" \
    && unzip promtail-linux-amd64.zip \
    && mv promtail-linux-amd64 /usr/local/bin/promtail \
    && rm promtail-linux-amd64.zip
COPY docker/promtail-conf.yaml /etc/promtail-conf.yaml
# Deployment steps ....
RUN composer install
RUN chmod +x /var/www/docker/run.sh

EXPOSE 80
HEALTHCHECK CMD curl --fail http://127.0.0.1 || exit 1
ENTRYPOINT ["/var/www/docker/run.sh"]
USER www-data
