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
 VersionBios=$( cat $RutaLecturaGen/bios.txt | grep -E "Version:")
 Placa_Madre=$(cat $RutaLecturaGen/placa_madre.txt | grep -E "Product Name:")
 Placa_Madre_Ver=$(cat $RutaLecturaGen/placa_madre.txt | grep -E "Version:")
 MemoriaRam=$(cat $RutaLecturaGen/memoria_ram.txt | grep "Size" )
 DiscoDuro=$()
 Procesador=$(sudo dmidecode -t processor | grep "Version")
 Numero_CoresCPU=$(grep -m 1 'siblings' /proc/cpuinfo | grep -Eo [0-9]) #siblings son el numero de cores virtuales



# Decodificador y verificador de tecnico #

    #variables de sección
    ArchivoLocal=/home/maxheadroom/Test_resultados/archivos_raw/SERIE_USB # ruta de archivo local de gabinete
    TecnicoBios=$(cat $RutaLecturaGen/gabinete.txt | grep  "Asset Tag:" | while read Col1 Col2 Col3; do echo $Col3; done )
    #ArchivoLocal Serie Ruta aqui de la USB de series, falta anexar esta parte

n=1
cat $ArchivoLocal/Listado_tecnicos.txt | while read TecnicoLista Nom1 Nom2 Nom3 Nom4 Nom5; do  
if [[ $TecnicoLista = $TecnicoBios ]]
    then      
        echo "$TecnicoLista $Nom1 $Nom2 $Nom3 $Nom4 $Nom5" > $RutaLecturaGen/temp_tec.txt;
        echo "Match $n $TecnicoLista $Nom1 $Nom2 $Nom3 $Nom4 $Nom5";
           else
        echo "no concuerda $n $TecnicoLista > $RutaLecturaGen/anomalias/anomalias.txt " ;   
    fi          
n=$((n+1))
done

# Decodificador de tecnico fin #

 # Dialog 1

dialog --begin 10 30 --backtitle "Información y Resultados" \
--title "Este equipo de computo lo realizo " \
--msgbox "Tecnico:"$'\n'"$TenicoMatch"$'\n'"Serie $SerieComputo "$'\n'"Modelo $ModeloPc"$'\n'"Memoria RAM:"$'\n'" $MemoriaRam"$'\n'"Tarjeta Madre Modelo:"$'\n'" $Placa_Madre"$'\n'"Tarjeta Madre Version:"$'\n'" $Placa_Madre_Ver"$'\n'"Procesador:"$'\n'" $Procesador"$'\n' 20 60 ;  clear



 