#!/bin/bash
#read -p "Enter two numbers a and b : " a b 
# Well you should do sanitize the user inputs for legal values
#cd /home/maxheadroom/Scripts/bash_script/ ;
. sum.sh
#sum "$a" "$b" 
notifi_array=( 
"1000" #Tiempo
"half-life-alyx" #icono
"Inicio de pruebas automaticas" #Titulo
"Por favor no desconecte el equipo o mueva el mouse, al finalizar las pruebas se le mandara un mensaje" # mensaje
)
sum "${notifi_array[@]}" && unset notifi_array
# Now the above line is high octane part
# The "./" mentions that the "sum" script is in the same  folder as the driver
# The values we populated went in as parameters
# Mind the double quotes.If the actual input has spaces double quotes serves 
# to preserve theme
# We are all done for the driver part