#!/bin/bash

echo "## SNAKEOIL Config"

make-ssl-cert generate-default-snakeoil --force-overwrite
openssl x509 -noout -subject -in /etc/ssl/certs/ssl-cert-snakeoil.pem

echo "## SNAKEOIL Updated"