#!/usr/bin/env bash

# Ignore the questions
export DEBIAN_FRONTEND=noninteractive
# Update
# --------------------
apt-get update
apt-get -y upgrade
# Mysql
# --------------------
# Install MySQL quietly
apt-get -q -y install mysql-server

# Install nginx + varnish + php-fpm
apt-get install -y mysql-client varnish vim nginx php5-fpm php5-cli php5-dev php5-mysql php5-curl php5-gd php5-mcrypt php5-sqlite php5-xmlrpc php5-xsl php5-common

# Prepare environment config
# --------------------
cp ./conf/nginx/sites-available/default /etc/nginx/sites-available/default
cp ./conf/mysql/my.cnf /etc/mysql/my.cnf
cp ./conf/php/php.ini /etc/php5/fpm/php.ini
cp ./conf/varnish/default.vcl /etc/varnish/
cp ./conf/varnish/varnish.conf /etc/default/varnish
echo $RANDOM | md5sum | awk '{ print $1 }' > /etc/varnish/secret

mkdir /var/www
chown www-data:www-data /var/www

rm /var/lib/mysql/ibdata1
rm /var/lib/mysql/ib_logfile0
rm /var/lib/mysql/ib_logfile1


service nginx restart
service php5-fpm restart
service mysql restart
service varnish restart
