FROM php:7.4-fpm-alpine

# PHP-FPM production settings
RUN mv $PHP_INI_DIR/php.ini-production $PHP_INI_DIR/php.ini

# Software updates & installation
RUN apk update && \
    apk upgrade && \
    apk add fcgi && \
    rm -f /var/cache/apk/*

# Copy health_checker
COPY health_checker /usr/local/bin

# Enable PHP-FPM status page, disable PHP-FPM access.log, set PHP-FPM ondemand, and make PHP-FPM Healtcheck runnable
RUN set -xe && \
    echo "pm.status_path = /status"      >> /usr/local/etc/php-fpm.d/zz-docker.conf && \
    echo "access.log = /dev/null"        >> /usr/local/etc/php-fpm.d/zz-docker.conf && \
    echo "pm = ondemand"                 >> /usr/local/etc/php-fpm.d/zz-docker.conf && \
    echo "pm.max_children = 3"           >> /usr/local/etc/php-fpm.d/zz-docker.conf && \
    echo "pm.process_idle_timeout = 10s" >> /usr/local/etc/php-fpm.d/zz-docker.conf && \
    echo "pm.max_requests = 200"         >> /usr/local/etc/php-fpm.d/zz-docker.conf && \
    echo "listen = /sock/app.sock"       >> /usr/local/etc/php-fpm.d/zz-docker.conf && \
    echo "listen.mode = 0660"            >> /usr/local/etc/php-fpm.d/zz-docker.conf && \
    chmod 111 /usr/local/bin/health_checker
