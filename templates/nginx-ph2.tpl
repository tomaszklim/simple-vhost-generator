server {
	listen 443 ssl;
	server_name @HOST www.@HOST;

	ssl_certificate /etc/letsencrypt/live/@HOST/fullchain.pem; # managed by Certbot
	ssl_certificate_key /etc/letsencrypt/live/@HOST/privkey.pem; # managed by Certbot
	include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
	ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

	ssl_stapling on;
	ssl_stapling_verify on;
	resolver 8.8.8.8 8.8.4.4;

	access_log /var/log/nginx/access-@HOST.log;
	error_log /var/log/nginx/error-@HOST.log;

	location / {
		proxy_pass              http://127.0.0.1:81;
		proxy_set_header        Host $host;
		proxy_set_header        X-Real-IP $remote_addr;
		proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
		proxy_connect_timeout   150;
		proxy_send_timeout      100;
		proxy_read_timeout      100;
		proxy_buffers           4 32k;
		client_max_body_size    8m;
		client_body_buffer_size 128k;
	}
}
