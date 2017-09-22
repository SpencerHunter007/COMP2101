#!/bin/bash

# Internal



# External
extip="$(curl --silent icanhazip.com)"
extname="$(nslookup $extip | grep -oP "name = \K.*")"

echo "External IP: ${extip}"
echo "External Name: ${extname}"
