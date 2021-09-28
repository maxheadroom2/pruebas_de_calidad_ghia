#!/bin/bash
# The script acts as a wrapper for the function sum
# Here we calculate the sum of parameters passed to the script
function sum(){
(( sum = $1 + $2 ))
echo "operacion es : $sum"
}

sum "$@" # Passing value from the shell script wrapper to the function
# $@ expands to the whole parameter input.
# What is special about "$@". Again, the spaces in the original parameters are preserved if those parameters were of the form "`A B"`.