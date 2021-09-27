#!/bin/bash
read -p "Enter two numbers a and b : " a b 
# Well you should do sanitize the user inputs for legal values
#cd /home/maxheadroom/Scripts/bash_script/ ;
./sum.sh 

1=$a
2=$b
sum $1 $2   
# Now the above line is high octane part
# The "./" mentions that the "sum" script is in the same  folder as the driver
# The values we populated went in as parameters
# Mind the double quotes.If the actual input has spaces double quotes serves 
# to preserve theme
# We are all done for the driver part