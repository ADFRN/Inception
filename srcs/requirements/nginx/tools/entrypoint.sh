#!/bin/bash
set -e

if [ ! -f /etc/nginx/ssl/inception.crt ]; then
	mkdir -p /etc/nginx/ssl
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout /etc/nginx/ssl/inception.key \
		-out /etc/nginx/ssl/inception.crt \
		-subj "/C=FR/ST=IDF/L=Paris/O=42/CN=${DOMAIN_NAME}"
fi

sed -i "s/__DOMAIN_NAME__/${DOMAIN_NAME}/g" /etc/nginx/nginx.conf

exec nginx -g "daemon off;"
