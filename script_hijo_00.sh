funcion_toor(){
Musica_pruebas=$(aescrypt -d -o - -p martha456 /home/maxheadroom/.Music_cache/lista_favoritos.txt.aes)
}

funcion_toor

echo $Musica_pruebas