# Overview

This is a simple vhost configuration generator for Apache2+Nginx+Certbot private webhosting stack.


# Server configuration

### Installing packages

```
add-apt-repository ppa:certbot/certbot
apt-get install nginx python-certbot-nginx
/etc/init.d/nginx stop
/opt/farm/ext/farm-roles/install.sh php-apache
apt-get install php-mbstring php-curl php-xml
touch /var/www/.subdirectories
```

### `/etc/apache2/ports.conf` file

Change `Listen 80` to `Listen 81`

### `/etc/nginx/sites-available/default` file

```
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    server_name _;
    return 301 https://$host$request_uri;
}
```

### Apache2 modules

```
a2dismod mpm_worker
a2dismod mpm_event
a2enmod php7.2
a2enmod headers
a2enmod rewrite
a2enmod remoteip
```
