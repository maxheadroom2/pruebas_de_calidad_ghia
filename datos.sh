#!/bin/bash
# -*- ENCODING: UTF-8 -*-

# Author: Victor Ruben Farias Rolón
# creado 12/10/2021
# modificado el 10 de Agosto 2021
# rev-1

funcion_variables(){
    RutaLecturaGen=$HOME/Test_resultados/archivos_raw/
    funcion_lista_musica | sudo -S ls /root && sudo parted -l > $RutaLecturaGen/discos_duros.txt
    export SerieComputo=$(cat $RutaLecturaGen/system.txt | grep "Serial Number:" | while read Col1 Col2 Col3; do echo $Col3; done )
    export ModeloPc=$(cat $RutaLecturaGen/system.txt | grep "SKU Number:" | while read Col1 Col2 Col3; do echo $Col3; done )
    export VersionBios=$(cat $RutaLecturaGen/bios.txt | grep -E "Version:" | while read Col1 Col2 Col3; do echo $Col2; done )
    export Placa_Madre=$(cat $RutaLecturaGen/baseboard.txt | grep -E "Product Name:" | while read Col1 Col2 Col3; do echo $Col3; done )
    export Placa_Madre_Ver=$(cat $RutaLecturaGen/baseboard.txt | grep -E "Version:" | while read Col1 Col2 Col3; do echo $Col2 $Col3; done )
    export MemoriaRam=$(cat $RutaLecturaGen/memory.txt | grep "Size" )
    export ModulosRam=$(cat $RutaLecturaGen/memory.txt | grep -e "Size" | grep -c "MB" )
    export Procesador=$(cat $RutaLecturaGen/processor.txt | grep -E "Version:" | while read Col1 Col2 Col3; do echo $Col3; done )
    export Numero_CoresCPU=$(grep -m 1 'siblings' /proc/cpuinfo | grep -Eo [0-9])
    export TecnicoBios=$(cat $RutaLecturaGen/chassis.txt | grep  "Asset Tag:" | while read Col1 Col2 Col3; do echo $Col3; done )
    #variables de disco duro
    export DiscoDescr=$(cat $RutaLecturaGen/lshw.txt | grep -wns "*-disk" -A 10 | grep  "descripción:" |  while read Col1 Col2 Col3; do echo $Col3; done )
    export DiscoCanti=$(cat $RutaLecturaGen/lshw.txt | grep -c "*-disk")
    export DiscoMod=$(cat $RutaLecturaGen/lshw.txt | grep -wns "*-disk" -A 10 | grep  "producto:" |  while read Col1 Col2 Col3; do echo $Col3; done )
    export DiscoSize=$(cat $RutaLecturaGen/lshw.txt | grep -wns "*-disk" -A 10 | grep  "tamaño:" |  while read Col1 Col2 Col3; do echo $Col3; done )
    export DiscoSerie=$(cat $RutaLecturaGen/lshw.txt | grep -wns "*-disk" -A 10 | grep  "serie:" |  while read Col1 Col2 Col3; do echo $Col3; done )
    export DiscoDuro=$(cat $RutaLecturaGen/discos_duros.txt | grep Disco | while read Col1 Col2 Col3; do echo $Col3; done )
    export DiscoTipoDepu=$(cat $RutaLecturaGen/lshw.txt | grep -wns "*-disk" -A 10 |  grep -e "capacidades:" | while read Col1 Col2 Col3; do echo $Col3; done )

    funcion_datos_discos_duros(){
        RutaLecturaGen=$HOME/Test_resultados/archivos_raw/
        n=$(cat $RutaLecturaGen/lshw.txt | grep -c "*-disk") #cantidad de discos encontrados en la unidad (unidades de almacenamiento)
        for (( c=1; c<=$n; c++ )) 
        do
        #echo "Unidad_$c-------------"
            declare -a arrayA=("capacidades:" "descripción:" "producto:" "serie:" "tamaño:")
            d=$(echo "${#arrayA[@]}")
            for (( a=0; a<$d; a++ )) 
            do
                arr[$c,$a]=$( 
                cat $RutaLecturaGen/lshw.txt | 
                grep -wns "*-disk" -A 10  |
                grep "${arrayA[$a]}" | 
                while read C1 C2 C3; do echo $C3; done | 
                cat -n | 
                sed -n  "$c"p"" |
                cut -f2 
                )
                #echo "matriz c $c -a $a"  
                #echo "${arr[$c,$a]}"
                #echo "${#arr[$c,$a]}"
                
                if [ "${arr[$c,$a]}" == "removable" ]; then
                echo "aqui" "${arr[$c,$a]}"
                
                else 
                echo "no" "${arr[$c,$a]}"
                fi
            done
        done
        }
    funcion_datos_discos_duros 
   
}