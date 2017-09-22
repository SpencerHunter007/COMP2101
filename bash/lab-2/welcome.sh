#!/bin/bash

export MYNAME="Spencer"
mytitle="Supreme Commander"

weekday=$(date +%A)
myhostname=$(hostname)

cat <<EOF
Welcome to planet $myhostname, $mytitle $MYNAME!
Today is $weekday
EOF
