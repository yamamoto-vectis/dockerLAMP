############################################################
# Dockerfile to build NewBiz container images
# Based on AmazonLinux
############################################################

# Set the base image to AmazonLinux
FROM amazonlinux:2018.03
MAINTAINER DuyHo

################## BEGIN INSTALLATION ######################

ADD sh/create-user.sh /tmp/create-user.sh
ADD sh/server-config.sh /tmp/server-config.sh
ADD php/10-php.conf /tmp/10-php.conf
ADD php/php.conf /tmp/php.conf
ADD sh/create-env.sh /tmp/create-env.sh
ADD sh/start-servers.sh /usr/sbin/start-servers
ADD php/php72 /tmp/php72
ADD xdebug/xdebug_php72 /tmp/xdebug_php72
ADD xdebug/xdebug_php71 /tmp/xdebug_php71
ADD xdebug/xdebug_php70 /tmp/xdebug_php70
ADD .lamp_env /tmp/.env
ADD php/5-php.conf /tmp/5-php.conf
ADD php/phpcustom /tmp/phpcustom

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
httpd24-devel \
diffutils \
re2c \
&& yum clean all

#Install Mysql server & client
RUN source /tmp/.env && \
yum -y install $mysql

#Install Apache or nginx
RUN source /tmp/.env && \
if [ -z $apache ] ; \
then yum -y install $nginx ;\
else yum -y install $apache ; fi

#Install PHP
RUN source /tmp/.env && \
if [ $php = phpcustom ]; \
then /bin/bash /tmp/$php ; \
else yum -y install $php* ; fi

# Install Composer
RUN cd .. && /usr/bin/curl -sS https://getcomposer.org/installer | /usr/bin/php && mv composer.phar /usr/bin/composer

# Install Xdebug 2.6
RUN source /tmp/.env && \
if [ $php = php72 ] ; \
then /bin/bash /tmp/xdebug_php72 ;\
elif [ $php = php71 ] ; \
then /bin/bash /tmp/xdebug_php71 ;\
elif [ $php = php70 ] ; \
then /bin/bash /tmp/xdebug_php70 ;\
else echo "Xdebug not installed" ; fi

RUN /bin/bash /tmp/create-user.sh && \
rm /tmp/create-user.sh && \
/bin/bash /tmp/server-config.sh && \
rm /tmp/server-config.sh && \
/bin/bash /tmp/create-env.sh && \
rm /tmp/create-env.sh

CMD /usr/bin/env bash start-servers;sleep infinity
