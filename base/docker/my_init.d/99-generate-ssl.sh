#!/bin/sh
# generate self signed ssl cert only if not present

if [ -e /etc/ssl/ssl.crt ] || [ -n "${SKIP_SSL_GENERATE}" ]; then
echo "Skipping SSL certificate generation"
else
echo "Generating self-signed certificate"

mkdir -p /etc/ssl
cd /etc/ssl

# Generating signing SSL private key
openssl genrsa -des3 -passout pass:x -out key.pem 2048

# Removing passphrase from private key
cp key.pem key.pem.orig
openssl rsa -passin pass:x -in key.pem.orig -out key.pem

# Generating certificate signing request
openssl req -new -key key.pem -out cert.csr -subj "/C=GB/ST=GB/L=London/O=OPG/OU=Digital/CN=default"

# Generating self-signed certificate
openssl x509 -req -days 3650 -in cert.csr -signkey key.pem -out cert.pem
fi
