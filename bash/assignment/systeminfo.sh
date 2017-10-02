#!/bin/bash

# This script implements the task in the bash semester assignment

# Declare variables and assign any default values.

# Define functions for error messages and displaying command line help.

function helpmsg {
  cat <<EOF
  Usage: $0 [-h | --help] [output option...]
  output option can be one or more of the following:
  -o | --osinfo
  -c | --cpuinfo
  -n | --namesinfo
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
      ;;
    -o|--osinfo)
      osinfowanted="yes"
      rundefault="no"
      ;;
    -c|--cpuinfo)

      ;;
    -n|--namesinfo)

      ;;
    *)
      echo "I don't recognize '$1'" >&2
      helpmsg >&2
      exit 1
      ;;
  esac
  shift
done

# Gather the data into variables, using arrays where helpful.

if [[ "$rundefault" = "yes" -o "" ]]; then
  osinfo="$(grep PRETTY /etc/os-release | sed -e 's/.*=//' -e 's/\"//g')"
fi

# Create the output using the gathered data and command line options.

# Display the output.

# Do any cleanup of temporary files if needed.
