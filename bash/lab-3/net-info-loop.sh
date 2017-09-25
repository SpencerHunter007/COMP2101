#!/bin/bash

interfaces=(`ip addr | egrep -o '^\w+'`)
echo $interfaces

getent hosts # ip and name lookup

ethtool # interface information
