#!/bin/bash
int="$(ip addr show ens33 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)"
ext="$(curl --silent icanhazip.com)"

echo "Internal IP: ${int}"
echo "External IP: ${ext}"
