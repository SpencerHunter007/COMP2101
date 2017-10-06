#!/bin/bash

# This script implements the task in the bash semester assignment

# Declare variables and assign any default values.

# Define functions for error messages and displaying command line help.

function helpmsg {
  cat <<EOF
  Usage: $0 [-h | --help] [output option...]
  output option can be one or more of the following:
  - | --
  - | --
  - | --
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
  ## Generate arrays
  intnameary=(`ip -o link show | awk -F': ' '{print $2}'`)
  intip4ary=()
  intip6ary=()
  #intdgary=()

  numints=${#intnameary[@]}
  intindex=0

  ## Populating arrays
  while [ $intindex -lt $numints ]; do
    #intname=(${intnameary[$intindex]})
    intip4ary=("${intip4ary[@]}" "$(ip addr show ${intnameary[$intindex]} | grep -w "inet" | awk '{print $2}' | cut -d '/' -f 1)")
    intip6ary=("${intip6ary[@]}" "$(ip addr show ${intnameary[$intindex]} | grep -w "inet6" | awk '{print $2}' | cut -d '/' -f 1)")
    #intdgary=("${intdgary[@]}" "$(ip route | grep via | grep ${intnameary[$intindex]} | awk '{print $3}')")

    intnameout=${intnameary[$intindex]}
    intip4out=${intip4ary[$intindex]}
    intip6out=${intip6ary[$intindex]}

cat <<EOF
  Interface: $intnameout
    IPv4: $intip4out
    IPv6: $intip6out
EOF
    intindex+=1
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

# Cleanup temporary files
