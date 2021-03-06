<VirtualHost *:81>
	ServerName @HOST
	ServerAlias *.@HOST

	DocumentRoot /var/www/@HOST
	<Directory /var/www/@HOST>
		Options FollowSymLinks
		AllowOverride All
	</Directory>

	RemoteIPHeader X-Forwarded-For
	RemoteIPTrustedProxy 127.0.0.1

	ErrorLog ${APACHE_LOG_DIR}/error-@HOST.log
	CustomLog ${APACHE_LOG_DIR}/access-@HOST.log combined
</VirtualHost>
