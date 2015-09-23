Ubuntu - Magento Production Environment Setup
===============================

## What will be installed

* nginx - 1.8.0
* php - 5.5 with mcrypt, pdo, curl, gd, sqlite, xmlrpc, xsl
* percona-server - 5.5
* varnish - 3.0
* git

Usage:

### Ubuntu 14.04:

```bash
$ wget -nv -O - https://raw.githubusercontent.com/SergeyCherepanov/lnpm-magento-prod/master/install-1404.sh | sudo bash
```

Put your code to /var/www/hostname.com/public_html
