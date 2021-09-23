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
# git-force-clone -b main https://github.com/maxheadroom2/pruebas_de_calidad_ghia.git ./bash_scripts ; sleep 1s && echo Neoteo456@ | sudo -S ls /root && sudo chmod u+x /home/maxheadroom/Scripts/bash_scripts/*.sh && bash "/home/maxheadroom/Scripts/bash_scripts/script_hijo_01.sh"

# Inicio de shell

#killall -9 curseofwar # matamos proceso del juego de prueba, asi mismo este se comentara cuando pase a producción
RutaLecturaGen=/home/maxheadroom/Test_resultados/archivos_raw/
funcion_notificacion(){
    if [[ $# = 4 ]]
        then
            notify-send -t "$1" -i "$2" "$3" "$4"   
        else
             notify-send -i "$1" "$2" "$3"
        fi          
}


source ./script_hijo_00XX.sh
funcion_Data



notifi_array=( 
"1000" #Tiempo
"half-life-alyx" #icono
"Inicio de pruebas automaticas" #Titulo
"Por favor no desconecte el equipo o mueva el mouse, al finalizar las pruebas se le mandara un mensaje" # mensaje
)
funcion_notificacion "${notifi_array[@]}" && unset notifi_array



funcion_borrado_basura(){
    #borrado de archivos inicio
    rm /home/maxheadroom/Test_resultados/archivos_raw/perfil_computo.txt
    rm /home/maxheadroom/Test_resultados/archivos_raw/temp_tec.txt
    rm /home/maxheadroom/Test_resultados/archivos_raw/discos_duros.txt
}

funcion_borrado_basura


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
    Msj_0="Serie del equipo de computo: "
    Msj_1="Siglas del tecnico: "
    Msj_2="Modelo del equipo de computo: "
    Msj_3="Version de Bios: "
    Msj_4="Codigo de Mother Board: "
    Msj_5="Version de Mother Board: "
    Msj_6="Procesador: "
    Msj_7="Datos de Disco(s) instalados ↓"
    Msj_8="Datos de Slots de Memoria RAM ↓"
       sleep .5s;
        array_msgbox=(
        "$Msj_0""\Zu$D0\Zu"$'\n'
        "$Msj_1""$D1"$'\n'
        "$Msj_2""$D2"$'\n'
        "$Msj_3""$D3"$'\n'
        "$Msj_4""$D4"$'\n'
        "$Msj_5""$D5"$'\n'
        "$Msj_6""$D6"$'\n'
        "$Msj_7"$'\n'
        "$D7"$'\n'
        "$Msj_8"$'\n'
        "$D8"$'\n' 26 90

    ) 
    TenicoMatch=$(cat $Ru/temp_tec.txt)# lee los datos del tecnico
    dialog --colors --begin 5 5 --backtitle "Información y Resultados"  \
    --title "Resultados de lectura del Equipo de computo " \
    --msgbox "${array_msgbox[@]}" && unset array_msgbox ;  clear
    
}

funcion_xterm_curseofwar(){
    # apertura de xterm curseofwar
    xterm -xrm 'XTerm.vt100.allowTitleOps: false'  -fa 'Monospace' -fs 9 -T terminal_curseofwar -e "curseofwar -W 90 -H 90" &
    sleep .5s;
    wmctrl -r "terminal_curseofwar" -b add,maximized_vert,maximized_horz && wmctrl -r "terminal_curseofwar" -t 3 #maximmizo la terminal de gtop
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
            notify-send -i aafm "Systema de pruebas automatico" "Se inserto USB"
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

funcion_stress_cpu
funcion_evaluacion_tecnico
funcion_dialog_resultado
#funcion_xterm_curseofwar
#funcion_memoria_usb