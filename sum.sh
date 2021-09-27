#!/bin/bash
# The script acts as a wrapper for the function sum
# Here we calculate the sum of parameters passed to the script
function sum(){
(( sum = $1 + $2 ))
echo "Sum : $sum"
}
function res(){
    if [[ $# = 4 ]]
        then
            notify-send -t "$1" -i "$2" "$3" "$4"   
        else
             notify-send -i "$1" "$2" "$3"
        fi          
}


sum "$@" # Passing value from the shell script wrapper to the function
# $@ expands to the whole parameter input.
# What is special about "$@". Again, the spaces in the original parameters are preserved if those parameters were of the form "`A B"`.