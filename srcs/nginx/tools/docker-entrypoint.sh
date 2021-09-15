#!/bin/sh

if [ ! -e /etc/ssl/certs/${DOMAIN_NAME}.crt ] ||
		[ ! -e /etc/ssl/private/${DOMAIN_NAME}.key ]; then
	echo "** creating certs file"
	openssl req -newkey rsa:4096 -days 365 -nodes -x509 \
		-subj "/C=MO/ST=Khouribga/L=Khouribga/O=42/OU=1337Khouribga/CN=${DOMAIN_NAME}" \
		-keyout /etc/ssl/private/${DOMAIN_NAME}.key \
		-out /etc/ssl/certs/${DOMAIN_NAME}.crt
	chmod 600 /etc/ssl/certs/${DOMAIN_NAME}.crt /etc/ssl/private/${DOMAIN_NAME}.key
fi

if [ -e /tmp/default.conf ]; then
	echo "** creating nginx config file"
	envsubst '$DOMAIN_NAME' < /tmp/default.conf > /etc/nginx/conf.d/default.conf
	rm -f /tmp/default.conf
fi

exec "$@"
