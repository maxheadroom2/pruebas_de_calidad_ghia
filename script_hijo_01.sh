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

# variables
 RutaLecturaGen=/home/maxheadroom/Test_resultados/archivos_raw/
 SerieComputo=$(cat $RutaLecturaGen/lshw.html | grep serie | grep -Eo '[0-9]{6}' | head -1)
 ModeloPc=$(cat $RutaLecturaGen/lshw.txt | grep -Eo PCGHIA-'[0-9]{4}' | head -1)
 VersionBios=$()
 MemoriaRam=$(cat $RutaLecturaGen/memoria_ram.txt | grep "Size" )
 DiscoDuro=$()
 Procesador=$(sudo dmidecode -t processor | grep "Version")
 Tecnico=$(cat $RutaLecturaGen/gabinete.txt | grep  "Asset Tag:" | while read Col1 Col2 Col3; do echo $Col3; done )
 Numero_CoresCPU=$(grep -m 1 'siblings' /proc/cpuinfo | grep -Eo [0-9]) #siblings son el numero de cores virtuales



# Decodificador de tecnico #

    #variables de sección
    ArchivoLocal=/home/maxheadroom/Test_resultados/archivos_raw/SERIE_USB # ruta de archivo local de gabinete
    #ArchivoLocal Serie Ruta aqui de la USB de series, falta anexar esta parte

NumFilas=$( | grep -Eo [0-9]{2} | head -1)
cat Listado_tecnicos.txt | while read Siglas Nom1 Nom2 Nom3 Nom4 Nom5; do
    echo "$Siglas : $Nom1 $Nom2 $Nom3 $Nom4 $Nom5"
done
n=1
cat $ArchivoLocal/Listado_tecnicos.txt | while read Siglas Nom1 Nom2 Nom3 Nom4 Nom5; do  
if [[ $Siglas = $Tecnico ]]
    then
        echo "Match $n $Siglas $Nom1 $Nom2 $Nom3 $Nom4 $Nom5"
        TecnicoK=$(echo "$n $Siglas $Nom1 $Nom2 $Nom3 $Nom4 $Nom5")
    else
        echo "no concuerda $n $Siglas"
        # crear aqui los datos de cuando no concuerdan
    fi          
n=$((n+1))
done

# Decodificador de tecnico fin #

 # Dialog 1

dialog --begin 10 30 --backtitle "Información y Resultados" \
--title "Este equipo de computo" \
--msgbox "Serie $SerieComputo "$'\n'"Modelo $ModeloPc"$'\n'"Memoria RAM"$'\n'" $MemoriaRam"$'\n'"Tecnico $TecnicoK" 20 30 ;  clear 



 