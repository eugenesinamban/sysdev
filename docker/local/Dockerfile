FROM sysdev_php-fpm:latest

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get install -y python \
    && apt-get install -y nodejs \
    && curl -L https://npmjs.org/install.sh | sh

RUN mv /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini \
    && rm /usr/local/etc/php/php.ini-*

COPY docker/local/webserver.sh /docker/local/webserver.sh

RUN chmod +x /docker/local/webserver.sh

ENTRYPOINT ["/docker/local/webserver.sh"]
