<VirtualHost *:81>
	ServerName @HOST
	ServerAdmin hosting@tomaszklim.pl
	DocumentRoot /var/www/@HOST

	ErrorLog ${APACHE_LOG_DIR}/error-@HOST.log
	CustomLog ${APACHE_LOG_DIR}/access-@HOST.log combined
</VirtualHost>