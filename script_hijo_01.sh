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
# git-force-clone -b main https://github.com/maxheadroom2/pruebas_de_calidad_ghia.git ./bash_scripts ; sleep 3s && echo Neoteo456@ | sudo -S ls /root && sudo chmod u+x /home/maxheadroom/Scripts/bash_scripts/*.sh && bash "/home/maxheadroom/Scripts/bash_scripts/script_hijo_01.sh"


# Inicio de scritp ############################################################

notify-send -i half-life-alyx "inicio de pruebas automaticas" "Por favor no desconecte el equipo o mueva el mouse, al finalizar las pruebas se le mandara un mensaje"
#borrado de archivos inicio
RutaLecturaGen=/home/maxheadroom/Test_resultados/archivos_raw/
rm $RutaLecturaGen/perfil_computo.txt
rm $RutaLecturaGen/temp_tec.txt

#archivos de inicio
# Estos comandos realizan los primeros archivos de extraccion de datos, asi es mas facil recuperar dicha información

# variables

 SerieComputo=$(cat $RutaLecturaGen/sistema_general.txt | grep "Serial Number:" | while read Col1 Col2 Col3; do echo $Col3; done )
 ModeloPc=$(cat $RutaLecturaGen/sistema_general.txt | grep "SKU Number:" | while read Col1 Col2 Col3; do echo $Col3; done )
 VersionBios=$(cat $RutaLecturaGen/bios.txt | grep -E "Version:")
 Placa_Madre=$(cat $RutaLecturaGen/placa_madre.txt | grep -E "Product Name:")
 Placa_Madre_Ver=$(cat $RutaLecturaGen/placa_madre.txt | grep -E "Version:")
 MemoriaRam=$(cat $RutaLecturaGen/memoria_ram.txt | grep "Size" )
 DiscoDuro=$()
 Procesador=$(cat $RutaLecturaGen/procesador.txt | grep -E "Version:")
 


# Decodificador y verificador de tecnico #

#variables de sección
ArchivoLocal=/home/maxheadroom/Test_resultados/archivos_raw/SERIE_USB # ruta de archivo local de gabinete
TecnicoBios=$(cat $RutaLecturaGen/gabinete.txt | grep  "Asset Tag:" | while read Col1 Col2 Col3; do echo $Col3; done )
#ArchivoLocal Serie Ruta aqui de la USB de series, falta anexar esta parte

# sección que crea el txt de la compu en version slim

sleep 2s;

touch $RutaLecturaGen/perfil_computo.txt
echo $SerieComputo > perfil_computo.txt
echo $ModeloP > perfil_computo.txt
echo $ModeloPco > perfil_computo.txt
echo $VersionBios > perfil_computo.txt
echo $Placa_Madre > perfil_computo.txt
echo $Placa_Madre_Ver > perfil_computo.txt
echo $MemoriaRam > perfil_computo.txt
echo $DiscoDuro > perfil_computo.txt
echo $Procesador > perfil_computo.txt

sleep 2s;

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

TenicoMatch=$(cat $RutaLecturaGen/temp_tec.txt)# lee los datos del tecnico
echo $TenicoMatch > perfil_computo.txt

dialog --begin 10 30 --backtitle "Información y Resultados" \
--title "Este equipo de computo lo realizo " \
--msgbox "Tecnico:"$'\n'"$TenicoMatch"$'\n'"Serie $SerieComputo "$'\n'"Modelo $ModeloPc"$'\n'"Memoria RAM:"$'\n'" $MemoriaRam"$'\n'"Tarjeta Madre Modelo:"$'\n'" $Placa_Madre"$'\n'"Tarjeta Madre Version:"$'\n'" $Placa_Madre_Ver"$'\n'"Procesador:"$'\n'" $Procesador"$'\n'"Bios versión:"$'\n'" $VersionBios"$'\n' 30 70 ;  clear



 