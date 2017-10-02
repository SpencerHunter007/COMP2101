#!/bin/bash
# this script enumerates our interfaces and
#   displays their configured IPV4 addresses
#   or informs us they don't have one if appropriate
# it demonstrates use of a DEBUG env var to allow debugging

# VARIABLES
###########
interfaces=(`ifconfig |grep '^[A-Za-z]'|awk '{print $1}'`) # an array of interface names configured on this machine
numinterfaces=${#interfaces[@]}
declare -A ips # will be a hash with ip addresses, keyed using interface name
intfindex=0 # will be used to iterate over the interfaces array

# MAIN
######
# display the interface count if we are doing debugging
[ "$DEBUG" ] && echo "We have $numinterfaces interfaces"
# iterate over the interfaces array
while [ $intfindex -lt $numinterfaces ]; do
# get the interface name from the interfaces array
  intfname="${interfaces[$intfindex]}"
# extract the assigned ip address(es) using ifconfig and store that in the ips hash
  ips[$intfname]="`ifconfig $intfname|grep 'inet '|sed -e 's/.*addr://' -e 's/ .*//'`"
# display the hash keys and values if we are debugging
  [ "$DEBUG" ] && echo "ips has ${!ips[*]} -> ${ips[*]}"
# display the interface and if it has any, its ip address(es)
  if [ -n "${ips[$intfname]}" ]; then
    echo "Interface $intfname has the address ${ips[$intfname]}"
  else
    echo "Interface $intfname has no ip address"
  fi
# increment the index and move on to the next interfaces array value
  intfindex+=1
done
