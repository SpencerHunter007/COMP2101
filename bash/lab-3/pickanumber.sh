#!/bin/bash

mynumber=$(( $RANDOM % 10 + 1 ))

read -p "Pick a number from 1 to 10, inclusive: " usernumber

while true; do
  if [ $mynumber -eq "$usernumber" ]; then
    echo "You got it!"
    exit
  else
    if [ $mynumber -gt "$usernumber" ]; then
      echo "Too low, guess again."
    else
      echo "Too high, guess again."
    fi
    # echo "Nope. Guess Again."
  fi
  read -p "Pick a number from 1 to 10, inclusive: " usernumber
done
