#!/bin/bash
# -*- ENCODING: UTF-8 -*-

# Author: Victor Ruben Farias Rolón
# creado 26 febrero 2016
# modificado el 10 de Agosto 2021
# rev-6

###############################################################################
# Descripcion: Scritp padre el cual desarrollara las pruebas del area de calidad                          
###############################################################################


# Inicio de scritp ############################################################

notify-send "Prueba" "datos"

#archivos de inicio
# Estos comandos realizan los primeros archivos de extraccion de datos, asi es mas facil recuperar dicha información

echo Neoteo456@ | sudo -S ls /root && sudo lshw -html > /home/maxheadroom/Test_resultados/archivos_raw/lshw.html
echo Neoteo456@ | sudo -S ls /root && sudo lshw > /home/maxheadroom/Test_resultados/archivos_raw/lshw.txt
echo Neoteo456@ | sudo -S ls /root && sudo dmidecode -t processor > /home/maxheadroom/Test_resultados/archivos_raw/procesador.txt
echo Neoteo456@ | sudo -S ls /root && sudo dmidecode -t bios > /home/maxheadroom/Test_resultados/archivos_raw/bios.txt
echo Neoteo456@ | sudo -S ls /root && sudo dmidecode -t baseboard > /home/maxheadroom/Test_resultados/archivos_raw/placa_madre.txt
echo Neoteo456@ | sudo -S ls /root && sudo dmidecode -t memory > /home/maxheadroom/Test_resultados/archivos_raw/memoria_ram.txt
echo Neoteo456@ | sudo -S ls /root && sudo dmidecode -t processor > /home/maxheadroom/Test_resultados/archivos_raw/procesador.txt
echo Neoteo456@ | sudo -S ls /root && sudo dmidecode -t system > /home/maxheadroom/Test_resultados/archivos_raw/sistema_general.txt
#Falta anexar el del disco duro


# variables

 SerieComputo=$(sudo lshw.html cat *.html | grep serie | grep -Eo '[0-9]{6}' | head -1)
 VersionBios=$()
 MemoriaRam=$(sudo dmidecode -t memory | grep "Size" && sudo dmidecode -t memory | grep "Bank Locator" && sudo dmidecode -t memory | grep "Serial Number")
 DiscoDuro=$()
 Procesador=$(sudo dmidecode -t processor | grep "Version")
 Tecnico=$()



