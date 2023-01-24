#!/bin/bash

echo "## PASSWORDS Config"

echo -e "${ROOT_PASS}\n${ROOT_PASS}" | sudo passwd root
echo -e "${DEBIAN_PASS}\n${DEBIAN_PASS}" | sudo passwd debian

echo "## PASSWORDS Updated"