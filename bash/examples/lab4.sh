#!/bin/bash
# This script implements the system report from lab4 of comp2101

# Declare variables and assign any default values.
runindefaultmode="yes"

# Define functions for error messages and displaying command line help.
function displayusage {
  echo "Usage:$0 [-h | --help] [-n] [-o]"
}
function errormessage {
  echo "$@" >&2
}

# Process the command line options, saving the results in variables for later use.
while [ $# -gt 0 ]; do
  case "$1" in
    -h|--help)
      displayusage
      exit 0
      ;;
    -n)
      namesinfowanted="yes"
      runindefaultmode="no"
      ;;
    -o)
      osinfowanted="yes"
      runindefaultmode="no"
      ;;
    *)
      errormessage "I don't know what '$1' is. Sorry."
      errormessage "$(displayusage)"
      exit 1
      ;;
  esac
  shift
done

# Gather the data into variables, using arrays where helpful.
osinfo="$(grep PRETTY /etc/os-release |sed -e 's/.*=//' -e 's/"//g')"
systemname="$(hostname)"
domainname="$(domainname)"

# Create the output using the gathered data and command line options.
osinfoformatted="
Operating System Information:
-----------------------------
$osinfo

"
nameinfoformatted="
System Names Information:
-----------------------------
Hostname: $systemname
Domainname: $domainname

"

# Display the output.
if [ "$runindefaultmode" = "yes" -o "$namesinfowanted" = "yes" ]; then
  echo "$nameinfoformatted"
fi
if [ "$runindefaultmode" = "yes" -o  "$osinfowanted" = "yes" ]; then
  echo "$osinfoformatted"
fi

# Do any cleanup of temporary files if needed
