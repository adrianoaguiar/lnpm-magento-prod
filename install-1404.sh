#!/usr/bin/env bash
# Ignore the questions
export DEBIAN_FRONTEND=noninteractive
TMPDIR=/tmp/lnpm-magento-prod
DEBCONF_PREFIX="percona-server-server-5.5 percona-server-server"
PERCONA_PW="root"
echo "${DEBCONF_PREFIX}/root_password password $PERCONA_PW" | sudo debconf-set-selections
echo "${DEBCONF_PREFIX}/root_password_again password $PERCONA_PW" | sudo debconf-set-selections

# Clean tmp dir
if [ -d ${TMPDIR} ]; then
    rm -rf ${TMPDIR}
fi

# Nginx repo
add-apt-repository -y ppa:nginx/stable

# Percona repo
apt-key adv --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A
echo "deb http://repo.percona.com/apt "$(lsb_release -sc)" main" | tee /etc/apt/sources.list.d/percona.list
echo "deb-src http://repo.percona.com/apt "$(lsb_release -sc)" main" | tee -a /etc/apt/sources.list.d/percona.list

# Update
# --------------------
apt-get update
apt-get -y upgrade

# Mysql
# --------------------
# Install Percona-Server
apt-get -q -y install percona-server-server-5.5

# Install git, nginx, varnish,php,php-fpm
apt-get install -y unzip git varnish nginx php5-fpm php5-cli php5-dev php5-mysql php5-curl php5-gd php5-mcrypt php5-sqlite php5-xmlrpc php5-xsl php5-common
php5enmod mcrypt

# Get configs
wget -O /tmp/conf.zip https://github.com/SergeyCherepanov/lnpm-magento-prod/archive/master.zip
unzip /tmp/conf.zip -d ${TMPDIR}
rm /tmp/conf.zip
cd ${TMPDIR}/$(ls -1 ${TMPDIR}/ | head -1)

# Prepare environment configs
# --------------------
cp ./conf/nginx/sites-available/default /etc/nginx/sites-available/default
cp ./conf/mysql/my.cnf /etc/mysql/my.cnf
cp ./conf/php/php.ini /etc/php5/fpm/php.ini
cp ./conf/varnish/default.vcl /etc/varnish/
cp ./conf/varnish/varnish.conf /etc/default/varnish
echo $RANDOM | md5sum | awk '{ print $1 }' > /etc/varnish/secret

mkdir -p /var/www
chown www-data:www-data /var/www
rm /var/lib/mysql/ibdata1
rm /var/lib/mysql/ib_logfile0
rm /var/lib/mysql/ib_logfile1


# Restart services
# --------------------
service nginx restart
service php5-fpm restart
service mysql restart
service varnish restart

rm -rf $TMPDIR
