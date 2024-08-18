FROM php:8.3-alpine
WORKDIR /opt/epever

# Enable edge repos...
RUN sed -i '/edge/s/^#//' /etc/apk/repositories

RUN apk add --no-cache \
    make \
    g++ \
    gcc \
    bash \
    composer

ADD src/composer.json composer.json

RUN composer install

ADD src/ .

HEALTHCHECK CMD pgrep php; if [ 0 != $? ]; then exit 1; fi;

CMD ["/bin/bash", "/opt/epever/entrypoint.sh"]