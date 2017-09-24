#!/bin/bash

intary=("lo" "ens33")
intcnt=${#intary[@]}

hname="$(hostname)"

int1ip4="$(ip addr show ${intary[0]} | grep -w "inet" | awk '{print $2}' | cut -d '/' -f 1)"
int1ip6="$(ip addr show ${intary[0]} | grep -w "inet6" | awk '{print $2}' | cut -d '/' -f 1)"

int2ip4="$(ip addr show ${intary[1]} | grep -w "inet" | awk '{print $2}' | cut -d '/' -f 1)"
int2ip6="$(ip addr show ${intary[1]} | grep -w "inet6" | awk '{print $2}' | cut -d '/' -f 1)"
int2dg="$(ip route | grep via | grep ${intary[1]} | awk '{print $3}')"

extip="$(curl --silent icanhazip.com)"
extname="$(nslookup $extip | grep -oP "name = \K.*")"

cat <<EOF
Hostname: $hname

Interface Count: $intcnt

Interface: ${intary[0]}
  IPv4: $int1ip4
  IPv6: $int1ip6

Interface: ${intary[1]}
  IPv4: $int2ip4
  IPv6: $int2ip6
  Default Gateway: $int2dg

External IP: $extip
External Name: $extname
EOF
