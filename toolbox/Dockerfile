FROM alpine:3.7

Maintainer Hiroshi Kurabayashi <kura@lifull-tech.vn>

RUN apk --update add wget curl git php7 php7-curl php7-openssl php7-json php7-phar php7-iconv php7-xml php7-tokenizer php7-simplexml php7-xmlwriter php7-dom nodejs-npm && rm /var/cache/apk/*
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

ADD ./composer.json /var/tmp/composer.json
RUN cd /var/tmp && composer install --dev
RUN ln -s /var/tmp/vendor/bin/phpcs /usr/bin/.
RUN ln -s /var/tmp/vendor/bin/phpmd /usr/bin/.

RUN cd /var/tmp && npm init -y
RUN cd /var/tmp && npm install --save-dev eslint-config-airbnb eslint-plugin-import eslint-plugin-react eslint-plugin-jsx-a11y eslint
RUN mkdir /mnt/src && chmod 777 /mnt/src

