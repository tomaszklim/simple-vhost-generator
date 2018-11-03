#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <host>"
	exit 0
fi

host=$1
echo "generating $host"

if [ ! -d /var/www/$host ]; then
	mkdir /var/www/$host
	echo "<?php\n\nphpinfo();\n" >/var/www/$host/index.php
fi

if [ ! -f /etc/apache2/sites-enabled/$host.conf ]; then
	cat templates/apache.tpl |sed "s/@HOST/$host/g" >/etc/apache2/sites-available/$host.conf
	a2ensite $host.conf
	/etc/init.d/apache2 reload
fi

if [ ! -f /etc/nginx/sites-enabled/$host ]; then
	cat templates/nginx-ph1.tpl |sed "s/@HOST/$host/g" >/etc/nginx/sites-available/$host
	ln -s /etc/nginx/sites-available/$host /etc/nginx/sites-enabled/$host
	/etc/init.d/nginx reload
fi

if [ ! -d /etc/letsencrypt/live/$host ]; then
	certbot -d $host -d www.$host
fi

if [ -d /etc/letsencrypt/live/$host ]; then
	cat templates/nginx-ph2.tpl |sed "s/@HOST/$host/g" >/etc/nginx/sites-available/$host
	/etc/init.d/nginx reload
fi
