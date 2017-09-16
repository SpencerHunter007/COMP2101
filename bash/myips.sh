#!/bin/bash
INT="$(ip addr show ens33 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)"
EXT="$(curl --silent icanhazip.com)"

echo "Internal IP: ${INT}"
echo "External IP: ${EXT}"
