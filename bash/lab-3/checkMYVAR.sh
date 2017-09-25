#!/bin/bash

[ -v MYVAR ] && echo "The variable MYVAR exists"
[ -v MYVAR ] || echo "The variable MYVAR does not exist"

[ -v MYVAR ] && [ -n "$MYVAR" ] && echo "The variable MYVAR has data in it"
[ -v MYVAR ] && [ -z "$MYVAR" ] && echo "The variable MYVAR is empty"
