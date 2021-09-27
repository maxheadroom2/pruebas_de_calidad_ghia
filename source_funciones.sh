#!/bin/bash
# -*- ENCODING: UTF-8 -*-

# Author: Victor Ruben Farias Rolón
# creado 27 septiembre 2021
# modificado ----
# rev-0

funcion_notificacion(){
    if [[ $# = 4 ]]
        then
            notify-send -t "$1" -i "$2" "$3" "$4"   
        else
             notify-send -i "$1" "$2" "$3"
        fi          
}

