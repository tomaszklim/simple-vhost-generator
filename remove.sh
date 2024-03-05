#!/bin/sh

remove_directory() {
	path=$1
	if [ -d $path ]; then
		echo "- $path"
		rm -rf $path
	fi
}

remove_file() {
	path=$1
	if [ -f $path ]; then
		echo "- $path"
		rm -f $path
	fi
}

archive_logs() {
	base=/var/log/$1
	mkdir -p $base/archived
	mv -t $base/archived $base/access-$2.* 2>/dev/null
	mv -t $base/archived $base/error-$2.* 2>/dev/null
}

if [ "$1" = "" ]; then
	echo "usage: $0 <host>"
	exit 0
fi

host=$1
echo "removing configuration files for $host"
remove_file /etc/nginx/sites-enabled/$host
remove_file /etc/apache2/sites-enabled/$host.conf
remove_file /etc/letsencrypt/renewal/$host.conf
remove_directory /etc/letsencrypt/live/$host
remove_directory /etc/letsencrypt/archive/$host

/etc/init.d/apache2 reload
/etc/init.d/nginx reload

archive_logs apache2 $host
archive_logs nginx $host
