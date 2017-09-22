#!/bin/bash

colours=("red" "green" "blue")

declare -A animals
animals=([red]="cardinal" [green]="frog" [blue]="lobster")

echo "My colours are: ${colours[*]}"
echo "The animals array contains "
echo "${animals[*]} are all in my array."

num=0
mycolour=${colours[$num]}
myanimal=${animals[$mycolour]}

echo "Number $num refers to a $mycolour $myanimal"
