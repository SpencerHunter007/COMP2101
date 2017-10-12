#!/bin/bash

# This script implements the task in the bash semester assignment

# Declare variables and assign any default values.

# Define functions for error messages and displaying command line help.

function helpmsg {
  cat <<EOF
  Usage: $0 [-h | --help] [output option...]
  output option can be one or more of the following:
  -h  | --help       Help menu
  -n  | --netinfo    System and domain name
  -i  | --ipinfo     IP addresses
  -o  | --osinfo     OS name and version
  -c  | --cpuinfo    CPU model
  -m  | --meminfo    Total memory
  -df | --diskfree   Disk space details
  -pr | --printers   List of printers
  -sw | --software   Installed software
EOF
}

function errormsg {
  echo "$@" >&2
}

# Process the command line options, saving the results in variables for later use.

rundefault="yes"
while [ $# -gt 0 ]; do
  case "$1" in
    -h|--help)
      helpmsg
      rundefault="no"
      ;;
    -n|--netinfo)
      netinfo="yes"
      rundefault="no"
      ;;
    -i|--ipinfo)
      ipinfo="yes"
      rundefault="no"
      ;;
    -o|--osinfo)
      osinfo="yes"
      rundefault="no"
      ;;
    -c|--cpuinfo)
      cpuinfo="yes"
      rundefault="no"
      ;;
    -m|--meminfo)
      meminfo="yes"
      rundefault="no"
      ;;
    -df|--diskfree)
      diskfree="yes"
      rundefault="no"
      ;;
    -pr|--printers)
      printers="yes"
      rundefault="no"
      ;;
    -sw|--software)
      software="yes"
      rundefault="no"
      ;;
    *)
      echo "I don't recognize '$1'" >&2
      helpmsg >&2
      exit 1
      ;;
  esac
  shift
done


# System and domain name
if [[ "$rundefault" = "yes" || "$netinfo" = "yes" ]]; then
  myhostname="$(hostname)"
  mydomainname="$(hostname -d)"
  myfqdn="$(hostname -f)"

cat <<EOF
--- Net Info ---
  Hostname: $myhostname
  Domain: $mydomainname
  FQDN: $myfqdn

EOF
fi

# IP Info
if [[ "$rundefault" = "yes" || "$ipinfo" = "yes" ]]; then
echo "--- IP Info ---"
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
      echo "  Interface $intfname has the address ${ips[$intfname]}"
    else
      echo "  Interface $intfname has no ip address"
    fi
  # increment the index and move on to the next interfaces array value
    intfindex+=1
  done
  echo ""
fi

# OS name and version
if [[ "$rundefault" = "yes" || "$osinfo" = "yes" ]]; then
  osinformation="$(grep PRETTY /etc/os-release | sed -e 's/.*=//' -e 's/\"//g')"

cat <<EOF
--- OS Info ---
  OS Info: $osinformation

EOF
fi

# CPU description
if [[ "$rundefault" = "yes" || "$cpuinfo" = "yes" ]]; then
  echo "--- CPU Details ---"
  lscpu | grep "Model name:"
  echo ""
fi

# Installed Memory
if [[ "$rundefault" = "yes" || "$meminfo" = "yes" ]]; then
echo "--- Total Memory ---"
  cat /proc/meminfo | grep MemTotal
echo ""
fi

# Available Disk Space
if [[ "$rundefault" = "yes" || "$diskfree" = "yes" ]]; then
  echo "--- Disk Space ---"
  df -h
  echo ""
fi

# List of Printers
if [[ "$rundefault" = "yes" || "$printers" = "yes" ]]; then
  echo "--- Printers ---"
  lpstat -p
  echo ""
fi

# Installed Software
if [[ "$rundefault" = "yes" || "$software" = "yes" ]]; then
  echo "--- Installed Software ---"
  apt list --installed
  echo ""
fi

# Cleanup temporary files
