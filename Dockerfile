############################################################
# Dockerfile to build NewBiz container images
# Based on AmazonLinux
############################################################

# Set the base image to AmazonLinux
FROM amazonlinux:latest
MAINTAINER DuyHo

################## BEGIN INSTALLATION ######################

ADD create-user.sh /tmp/create-user.sh
ADD server-config.sh /tmp/server-config.sh
ADD 10-php.conf /tmp/10-php.conf
ADD php.conf /tmp/php.conf
ADD create-env.sh /tmp/create-env.sh
ADD start-servers.sh /usr/sbin/start-servers

ADD .env /tmp/.env

RUN yum update -y && yum install -y \
sudo \
gcc \
libxml2-devel \
openssl-devel \
libcurl-devel \
autoconf \
wget \
yum \
git \
&& yum clean all

#Install Mysql server & client
RUN source /tmp/.env && \
yum -y install $mysql $mysql-server

#Install Apache
RUN source /tmp/.env && \
yum -y install $apache $apache-devel

#Install nginx
RUN source /tmp/.env && \
yum -y install $nginx

#Install php
RUN source /tmp/.env && \
if [ $php = php72 ] ; \
then yum -y install php71 libzip libzip-devel \
&& wget -O php-7.2.4.tar.gz http://jp2.php.net/get/php-7.2.4.tar.gz/from/this/mirror \
&& tar -xzpvf php-7.2.4.tar.gz \
&& cd php-7.2.4 \
&& ./configure --with-apxs2=/usr/bin/apxs --with-zlib-dir --with-zlib --enable-mysqlnd --enable-mbstring --with-pdo-mysql --with-mysqli --with-mysql-sock=/var/run/mysqld/mysqld.sock --with-curl=/usr/bin/curl --with-openssl \
&& make \
&& make install \
&& cp php.ini-production /usr/local/lib/php.ini \
&& mv /usr/bin/php /usr/bin/php.bk \
&& ln -s /usr/local/bin/php /usr/bin/php \
&& cd .. \
&& wget http://pecl.php.net/get/zip-1.13.5.tgz \
&& tar -xzpvf zip-1.13.5.tgz \
&& cd zip-1.13.5 \
&& phpize \
&& ./configure \
&& make \
&& make install \
&& echo "extension=zip.so" >> /usr/local/lib/php.ini \
&& cp /tmp/10-php.conf /etc/httpd/conf.modules.d/10-php.conf \
&& cp /tmp/php.conf /etc/httpd/conf.d/php.conf ; \
else yum -y install $php* ; fi

# Install Composer
RUN cd .. && /usr/bin/curl -sS https://getcomposer.org/installer | /usr/bin/php && mv composer.phar /usr/bin/composer

# Install Xdebug 2.6
RUN source /tmp/.env && \
if [ $php = php72 ] ; \
then cd .. \
&& wget http://xdebug.org/files/xdebug-2.6.0.tgz \
&& tar -xzpvf xdebug-2.6.0.tgz \
&& cd xdebug-2.6.0 \
&& phpize \
&& ./configure \
&& make \
&& cp modules/xdebug.so /usr/local/lib/php/extensions/no-debug-non-zts-20170718 \
&& echo "zend_extension = /usr/local/lib/php/extensions/no-debug-non-zts-20170718/xdebug.so" >> /usr/local/lib/php.ini; \
elif [ $php = php71 ] ; \
then cd .. \
&& wget http://xdebug.org/files/xdebug-2.6.0.tgz \
&& tar -xzpvf xdebug-2.6.0.tgz \
&& cd xdebug-2.6.0 \
&& phpize \
&& ./configure \
&& make \
&& cp modules/xdebug.so /usr/lib64/php/7.1/modules \
&& echo "zend_extension = /usr/lib64/php/7.1/modules/xdebug.so" >> /etc/php.ini; \
elif [ $php = php70 ] ; \
then cd .. \
&& wget http://xdebug.org/files/xdebug-2.6.0.tgz \
&& tar -xzpvf xdebug-2.6.0.tgz \
&& cd xdebug-2.6.0 \
&& phpize \
&& ./configure \
&& make \
&& cp modules/xdebug.so /usr/lib64/php/7.0/modules \
&& echo "zend_extension = /usr/lib64/php/7.0/modules/xdebug.so" >> /etc/php.ini; \
else echo "Xdebug 2.6 isn't supported on php5 " ; fi

EXPOSE 80
EXPOSE 443
EXPOSE 3306

RUN /bin/bash /tmp/create-user.sh && \
rm /tmp/create-user.sh && \
/bin/bash /tmp/server-config.sh && \
rm /tmp/server-config.sh && \
/bin/bash /tmp/create-env.sh && \
rm /tmp/create-env.sh

CMD /usr/bin/env bash start-servers;sleep infinity



