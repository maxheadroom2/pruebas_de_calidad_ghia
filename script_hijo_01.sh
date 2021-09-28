#!/bin/bash
# -*- ENCODING: UTF-8 -*-

# Author: Victor Ruben Farias Rolón
# creado 26 febrero 2016
# modificado el 10 de Agosto 2021
# rev-6

# programas anexos 
# bashfuscator Link https://snapcraft.io/install/bashfuscator/ubuntu & https://bashfuscator.readthedocs.io/en/latest/Usage.html  sudo snap install bashfuscator --edge
# aescrypt link https://forums.packetizer.com/viewtopic.php?t=1173 & https://www.aescrypt.com/linux_aes_crypt.html

###############################################################################
# Descripcion: Scritp padre el cual desarrollara las pruebas del area de calidad                          
###############################################################################

# notas 
# GIT 
# Para actualizar el script en el equipo de produccion cree un alias en ~/.bashrc a lo cual añadi una funcion llamada funcion_actualizar_script()
# donde esta funcion la llama el alias de update-script.
# Ofuscando codigo
# Para ofuscar el txt plano use aescrypt en el cual añado el script original no ofuscado al .gitignore a lo cual
# cree un script donde usando bashfuscator creo un  .sh con los datos para ofuscar el codigo de lectura del txt
# esto por que use un esquema para mandar la clave de root por medio de una tuberia, evitando que se vea en texto plano 
# parametros de bashofuscator, para hacerlo mas ligero ya que puede crear script muy pesados y se llegan a colgar
# bashfuscator -c "echo contraseña_root" --choose-mutators compress/bzip2 command/case_swapper command/reverse --layers 1 --test
# instalar sudo apt install git-extras y dialog

. source_funciones.sh

function_preparacion_entorno(){
    DIR1=/home/maxheadroom/.Music_cache/
    DIR2=/home/maxheadroom/Nextcloud/Laborales/Sistema_pruebas/Archivo_de_pruebas_computo/Archivos_cache_planos/Lista_favoritos.7z
    DIR3=/home/maxheadroom/.Music_cache/
    if [ -d "$DIR1" ]
        then
        echo "El directorio ${DIR1} existe"
            else
            echo "El directorio ${DIR1} no existe"
            mkdir /home/maxheadroom/.Music_cache/ && 
            cd ${DIR3} && wget https://cvacloud.grupocva.com/index.php/s/BaY2KowzWDPFxBA/download &&
            #cp ${DIR2} ${DIR3} && #Comento esta parte ya que en caso de no tener nextcloud instalado mejor lo descargo de internet
            7za e ${DIR3}
    fi
}



# Inicio de shell

killall -9 curseofwar


RutaLecturaGen=/home/maxheadroom/Test_resultados/archivos_raw/

source ./script_hijo_00XX.sh
funcion_Data

notifi_array=( 
"1000" #Tiempo
"half-life-alyx" #icono
"Inicio de pruebas automaticas" #Titulo
"Por favor no desconecte el equipo o mueva el mouse, al finalizar las pruebas se le mandara un mensaje" # mensaje
)
funcion_notificacion "${notifi_array[@]}" && unset notifi_array



funcion_borrado_basura


funcion_creacion_reportes

#archivos de inicio
# Estos comandos realizan los primeros archivos de extraccion de datos, asi es mas facil recuperar dicha información

# variables

 SerieComputo=$(cat $RutaLecturaGen/sistema_general.txt | grep "Serial Number:" | while read Col1 Col2 Col3; do echo $Col3; done )
 ModeloPc=$(cat $RutaLecturaGen/sistema_general.txt | grep "SKU Number:" | while read Col1 Col2 Col3; do echo $Col3; done )
 VersionBios=$(cat $RutaLecturaGen/bios.txt | grep -E "Version:" | while read Col1 Col2 Col3; do echo $Col2; done )
 Placa_Madre=$(cat $RutaLecturaGen/placa_madre.txt | grep -E "Product Name:")
 Placa_Madre_Ver=$(cat $RutaLecturaGen/placa_madre.txt | grep -E "Version:")
 MemoriaRam=$(cat $RutaLecturaGen/memoria_ram.txt | grep "Size" )
 funcion_Data | sudo -S ls /root && sudo parted -l > $RutaLecturaGen/discos_duros.txt
 DiscoDuro=$(cat $RutaLecturaGen/discos_duros.txt | grep Disco | while read Col1 Col2 Col3; do echo $Col3; done )
 Procesador=$(cat $RutaLecturaGen/procesador.txt | grep -E "Version:")
 Numero_CoresCPU=$(grep -m 1 'siblings' /proc/cpuinfo | grep -Eo [0-9])
 
# Decodificador y verificador de tecnico #

#variables de sección
ArchivoLocal=/home/maxheadroom/Test_resultados/archivos_raw/SERIE_USB # ruta de archivo local de gabinete
TecnicoBios=$(cat $RutaLecturaGen/gabinete.txt | grep  "Asset Tag:" | while read Col1 Col2 Col3; do echo $Col3; done )
#ArchivoLocal Serie Ruta aqui de la USB de series, falta anexar esta parte

touch $RutaLecturaGen/perfil_computo.txt
echo $SerieComputo >> $RutaLecturaGen/perfil_computo.txt
echo $ModeloPc >> $RutaLecturaGen/perfil_computo.txt
echo $VersionBios >> $RutaLecturaGen/perfil_computo.txt
echo $Placa_Madre >> $RutaLecturaGen/perfil_computo.txt
echo $Placa_Madre_Ver >> $RutaLecturaGen/perfil_computo.txt
echo $MemoriaRam >> $RutaLecturaGen/perfil_computo.txt
echo $DiscoDuro >> $RutaLecturaGen/perfil_computo.txt
echo $Procesador >> $RutaLecturaGen/perfil_computo.txt




funcion_xterm_curseofwar
funcion_stress_cpu
funcion_evaluacion_tecnico
funcion_dialog_resultado

#funcion_memoria_usb