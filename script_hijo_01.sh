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

#source ./script_hijo_00XX.sh

for i in $HOME/.Music_cache/*;
  do source $i
done

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

funcion_notificacion(){
    if [[ $# = 4 ]]
        then
            notify-send -t "$1" -i "$2" "$3" "$4"   
        else
             notify-send -i "$1" "$2" "$3"
        fi          
}

funcion_memoria_usb(){
    usb=SERIES
    WHILE=0
    while [ $CONTROL=0 ] ; do
    df | grep $usb >> /dev/null

    if [ $? -ne 1 ];
        then
            dialog --backtitle "Inserto de memoria USB" --title "Se te redirecionara al menu de la memoria para que puedas copiar la informacion a la USB" --infobox "Datos aqui" 25 50
            sleep 1s;
            funcion_notificacion \
            #tiempo \
            "aafm" \
            "Systema de pruebas automatico" \
            "Se inserto USB" && unset notifi_array\
            clear
            exit
        else
            notify-send -t 2000 -i among-us "Systema de pruebas automatico" "No hay USB montada"
        fi
            sleep 1s
        done
}

funcion_stress_cpu(){
        notifi_array=( 
            "cpu" #icono
            "Inicio de prueba de Stress del Procesador" #Titulo
            "Por cada nucleo virtual se crean $Numero_CoresCPU ciclos de YES, esto hara que el equipo se pueda sobrecalentar cuidado" # mensaje
        )
        funcion_notificacion "${notifi_array[@]}" && unset notifi_array
    for (( c=1; c<=$Numero_CoresCPU; c++ ))
        do  
            yes > /dev/null & # ciclo
            echo "veces que repitermos yes"
            sleep 1s;
        done
            sleep 10s && killall -9 yes; # tiempo de espera para matar yes
            notifi_array=( 
                "2000" #Tiempo
                "ace" #icono
                "Eliminamos YES" #Titulo
                "Damos de baja el proceso YES" # mensaje
            )
        funcion_notificacion "${notifi_array[@]}" && unset notifi_array
}

funcion_init_01(){
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
}

funcion_creacion_reportes(){
    funcion_lista_musica | sudo -S ls /root && sudo lshw -html > /home/maxheadroom/Test_resultados/archivos_raw/lshw.html
    funcion_lista_musica | sudo -S ls /root && sudo lshw > /home/maxheadroom/Test_resultados/archivos_raw/lshw.txt
    
    funcion_dmidecode(){
        ruta=/home/maxheadroom/Test_resultados/archivos_raw/
        funcion_lista_musica | sudo -S ls /root && sudo dmidecode -t $reportes_array_dmi > $ruta/$nombre_dmi.txt
    }

    reportes_array_dmi=(
        "processor"
        "bios"
        "baseboard"
        "memory"
        "system"
        "chassis"
    )
    funcion_dmidecode "${reportes_array_dmi[@]}" && unset notifi_array
        reportes_array_dmi=(
        "procesador"
        "bios"
        "placa_madre"
        "memoria_ram"
        "sistema_general"
        "gabinete"
    )
    funcion_dmidecode "${nombre_dmi[@]}" && unset notifi_array
}

funcion_borrado_basura(){
    #borrado de archivos inicio
    rm /home/maxheadroom/Test_resultados/archivos_raw/perfil_computo.txt
    rm /home/maxheadroom/Test_resultados/archivos_raw/temp_tec.txt
    rm /home/maxheadroom/Test_resultados/archivos_raw/discos_duros.txt
}

funcion_evaluacion_tecnico(){
    n=1
    cat $ArchivoLocal/Listado_tecnicos.txt | while read TecnicoLista Nom1 Nom2 Nom3 Nom4 Nom5; do  
    if [[ $TecnicoLista = $TecnicoBios ]]
        then      
            echo "$TecnicoLista $Nom1 $Nom2 $Nom3 $Nom4 $Nom5" > $RutaLecturaGen/temp_tec.txt;
            echo "$TecnicoLista $Nom1 $Nom2 $Nom3 $Nom4 $Nom5" >> $RutaLecturaGen/perfil_computo.txt;
            echo "Match $n $TecnicoLista $Nom1 $Nom2 $Nom3 $Nom4 $Nom5";
        else
            echo "no concuerda $n $TecnicoLista > $RutaLecturaGen/anomalias/anomalias.txt " ;   
        fi          
            n=$((n+1))
    done
}

funcion_dialog_resultado(){
    #variables del dialog
    D0=$SerieComputo
    D1=$TecnicoBios
    D2=$ModeloPc
    D3=$VersionBios
    D4=$Placa_Madre
    D5=$Placa_Madre_Ver
    D6=$Procesador
    D7=$DiscoDuro
    D8=$MemoriaRam
    #Variables del texto para caja del dialog
    M0="Serie del equipo de computo: "
    M1="Siglas del tecnico: "
    M2="Modelo del equipo de computo: "
    M3="Version de Bios: "
    M4="Codigo de Mother Board: "
    M5="Version de Mother Board: "
    M6="Procesador: "
    M7="Datos de Disco(s) instalados ↓"
    M8="Datos de Slots de Memoria RAM ↓"
    TenicoMatch=$(cat $Ru/temp_tec.txt)# lee los datos del tecnico
    sleep .5s;
    array_msgbox=(
        "$M0""$D0"$'\n'
        "$M1""$D1'"$'\n'
        "$M1""$D1"$'\n'
        "$M2""$D2"$'\n'
        "$M3""$D3"$'\n'
        "$M4""$D4"$'\n'
        "$M5""$D5"$'\n'
        "$M6""$D6"$'\n'
        "$M7"$'\n'
        "$D7"$'\n'
        "$M8"$'\n'
        "$D8"$'\n'
    );
    
    function dialog_menu_01()
    {
        dialog --clear \
        --colors --begin 5 5 \
        --backtitle "${1}" \
        --title "${2}" \
        --msgbox "${!3}" 26 90
    }
    dialog_menu_01 "Informacion y Resultados" \
    "Resultados de lectura del Equipo de computo" array_msgbox[*] # Nota usar * concatena y usar @ envia variables 1 x 1
    unset array_msgbox ;  
    clear
}

funcion_xterm_curseofwar(){
    
    killall -9 curseofwar
    killall -9 htop
   
    # apertura de xterm 1
    xterm -xrm 'XTerm.vt100.allowTitleOps: false'  -fa 'Monospace' -fs 14  -T terminal_bashtop -e "bashtop" &
    sleep 2s;
    wmctrl -r "terminal_bashtop" -b add,maximized_vert,maximized_horz && wmctrl -r "terminal_bashtop" -t 1 #maximmizo la terminal de gtop

    # apertura de xterm 2
    sleep 1s;
    xterm -xrm 'XTerm.vt100.allowTitleOps: false'  -fa 'Monospace' -fs 14  -T terminal_htop -e "htop" &
    sleep 2s;
    wmctrl -r "terminal_htop" -b add,maximized_vert,maximized_horz && wmctrl -r "terminal_htop" -t 2 #maximmizo la terminal de gtop

    # apertura de xterm curseofwar
    xterm -xrm 'XTerm.vt100.allowTitleOps: false'  -fa 'Monospace' -fs 9 -T terminal_curseofwar -e "curseofwar -W 90 -H 90" &
    sleep .5s;
    wmctrl -r "terminal_curseofwar" -b add,maximized_vert,maximized_horz && wmctrl -r "terminal_curseofwar" -t 3 #maximmizo la terminal de gtop

     # apertura de xterm curseofwar
    xterm -xrm 'XTerm.vt100.allowTitleOps: false'  -fa 'Monospace' -fs 9 -T terminal_sensors -e "curseofwar -W 90 -H 90" &
    sleep .5s;
    wmctrl -r "terminal_sensors" -b add,maximized_vert,maximized_horz && wmctrl -r "terminal_sensors" -t 3 #maximmizo la terminal de gtop
}

# Inicio de shell

RutaLecturaGen=/home/maxheadroom/Test_resultados/archivos_raw/


notifi_array=( 
"1000" #Tiempo
"half-life-alyx" #icono
"Inicio de pruebas automaticas" #Titulo
"Por favor no desconecte el equipo o mueva el mouse, al finalizar las pruebas se le mandara un mensaje" # mensaje
)
funcion_notificacion "${notifi_array[@]}" && unset notifi_array

funcion_borrado_basura
funcion_creacion_reportes


# Estos comandos realizan los primeros archivos de extraccion de datos, asi es mas facil recuperar dicha información

# variables

 SerieComputo=$(cat $RutaLecturaGen/sistema_general.txt | grep "Serial Number:" | while read Col1 Col2 Col3; do echo $Col3; done )
 ModeloPc=$(cat $RutaLecturaGen/sistema_general.txt | grep "SKU Number:" | while read Col1 Col2 Col3; do echo $Col3; done )
 VersionBios=$(cat $RutaLecturaGen/bios.txt | grep -E "Version:" | while read Col1 Col2 Col3; do echo $Col2; done )
 Placa_Madre=$(cat $RutaLecturaGen/placa_madre.txt | grep -E "Product Name:")
 Placa_Madre_Ver=$(cat $RutaLecturaGen/placa_madre.txt | grep -E "Version:")
 MemoriaRam=$(cat $RutaLecturaGen/memoria_ram.txt | grep "Size" )
 funcion_lista_musica | sudo -S ls /root && sudo parted -l > $RutaLecturaGen/discos_duros.txt
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