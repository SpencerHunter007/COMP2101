#!/bin/bash

dicenum=$1
sidenum=$2

if [ -z "$1" ]; then
  read -p "How many dice would you like to roll? (1 - 5) [2]: " dicenum
else
  echo "How many dice would you like to roll? (1 - 5) [2]: $dicenum"
fi

if [ -z "$2" ]; then
  read -p "How many sides should the dice have? (4 - 20) [6]: " sidenum
else
  echo "How many sides should the dice have? (4 - 20) [6]: $sidenum"
fi

if [ "$dicenum" = "" ]; then
  dicenum=2
else
  if ((  )); then
    echo "Bad dice number!"
  fi
fi

if [ "$sidenum" = "" ]; then
  sidenum=6
else
  if ((  )); then
    echo "Bad sides number!"
  fi
fi

echo Dice: $dicenum
echo Sides: $sidenum

: '
count=0
while [ "$count" -lt "$dicenum" ]; do
  count=$(($count + 1))
  echo $count
done
'
