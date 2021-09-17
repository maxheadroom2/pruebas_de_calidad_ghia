#!/bin/bash
# -*- ENCODING: UTF-8 -*-

# Author: Victor Ruben Farias Rolón
# creado 26 febrero 2016
# modificado el 10 de Agosto 2021
# rev-6

###############################################################################
# Descripcion: Scritp padre el cual desarrollara las pruebas del area de calidad                          
###############################################################################

# notas 
# git-force-clone -b main https://github.com/maxheadroom2/pruebas_de_calidad_ghia.git ./bash_scripts && sudo chmod u+x *.sh


# Inicio de scritp ############################################################

notify-send -i half-life-alyx "inicio de pruebas automaticas" "Por favor no desconecte el equipo o mueva el mouse, al finalizar las pruebas se le mandara un mensaje"

#archivos de inicio
# Estos comandos realizan los primeros archivos de extraccion de datos, asi es mas facil recuperar dicha información

rm -f /home/maxheadroom/Test_resultados/archivos_raw/*

source ./script_hijo_00XX.sh
funcion_Data

funcion_Data | sudo -S ls /root && sudo lshw -html > /home/maxheadroom/Test_resultados/archivos_raw/lshw.html
funcion_Data | sudo -S ls /root && sudo lshw > /home/maxheadroom/Test_resultados/archivos_raw/lshw.txt
funcion_Data | sudo -S ls /root && sudo dmidecode -t processor > /home/maxheadroom/Test_resultados/archivos_raw/procesador.txt
funcion_Data | sudo -S ls /root && sudo dmidecode -t bios > /home/maxheadroom/Test_resultados/archivos_raw/bios.txt
funcion_Data | sudo -S ls /root && sudo dmidecode -t baseboard > /home/maxheadroom/Test_resultados/archivos_raw/placa_madre.txt
funcion_Data | sudo -S ls /root && sudo dmidecode -t memory > /home/maxheadroom/Test_resultados/archivos_raw/memoria_ram.txt
funcion_Data | sudo -S ls /root && sudo dmidecode -t processor > /home/maxheadroom/Test_resultados/archivos_raw/procesador.txt
funcion_Data | sudo -S ls /root && sudo dmidecode -t system > /home/maxheadroom/Test_resultados/archivos_raw/sistema_general.txt
funcion_Data | sudo -S ls /root && sudo dmidecode -t chassis > /home/maxheadroom/Test_resultados/archivos_raw/gabinete.txt
#Falta anexar el del disco duro


# variables

 #ooSerieComputo=$(cat lshw.html | grep serie | grep -Eo '[0-9]{6}' | head -1)
 VersionBios=$()
 MemoriaRam=$(sudo dmidecode -t memory | grep "Size" && sudo dmidecode -t memory | grep "Bank Locator" && sudo dmidecode -t memory | grep "Serial Number")
 DiscoDuro=$()
 Procesador=$(sudo dmidecode -t processor | grep "Version")
 Tecnico=$()
 Numero_CoresCPU=$(grep -m 1 'siblings' /proc/cpuinfo | grep -Eo [0-9]) #siblings son el numero de cores virtuales

# Script inicio de comandos

# apertura de xterm 1

xterm -xrm 'XTerm.vt100.allowTitleOps: false'  -fa 'Monospace' -fs 14  -T terminal_1 -e "gtop" &
sleep 2s;
wmctrl -r "terminal_1" -b add,maximized_vert,maximized_horz && wmctrl -r "terminal_1" -t 1 #maximmizo la terminal de gtop

# apertura de xterm 2
sleep 1s;
xterm -xrm 'XTerm.vt100.allowTitleOps: false'  -fa 'Monospace' -fs 14  -T terminal_2 -e "htop" &
sleep 2s;
wmctrl -r "terminal_2" -b add,maximized_vert,maximized_horz && wmctrl -r "terminal_2" -t 2 #maximmizo la terminal de gtop

# seccion de ciclo de yes por cada core del cpu del equipo

for (( c=1; c<=$Numero_CoresCPU; c++ ))
do  
  yes > /dev/null & # ciclo
  echo "veces que repitermos yes"
  notify-send -i half-life-alyx "yes yes yes" "yes"
  sleep 1s;
done