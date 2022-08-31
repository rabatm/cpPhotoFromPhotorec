#!/bin/bash

#Script destiné à ordonner les fichier récupére avec photorec
# By Martin . R
# Date 31/08/2022

# Dossier racine qui contient tous les dossier
DOSSIERINITIAL="./"

#Dossier destinataire
DOSSIERDEST="/Recup"
# Délémiteur de la chaine de caractére
IFS='-'

function isPicture() {
    picture=$1
    extention=${picture##*.}
    if [ $extention == "jpg" ];
    then 
        echo 1
    else
        echo 0
    fi
}

function checkFolder() {
    folder=$DOSSIERDEST$1
    if [ ! -d "$folder" ]; then
        # Si le dossier n'existe pas on le crée
        mkdir  $folder
    fi
}

for folder in $DOSSIERINITIAL*; do 
    for file in $folder/*; do
        fileDate=$(date -r $file "+%Y-%m-%d-%H%M%S")
        read -ra date <<< "$fileDate"   # str is read into an array as tokens separated by IFS     
        yearOfFile=${date[0]}
        monthOfFile=${date[1]}
        dayOfFile=${date[2]}
        timeOfFile=${date[3]}
        checkFolder $yearOfFile
        checkFolder $yearOfFile/$monthOfFile
        if [ $(isPicture $file) -eq 1 ]; then 
            cp $file $DOSSIERDEST$yearOfFile/$monthOfFile/$yearOfFile-$monthOfFile-$dayOfFile-$timeOfFile.jpg
        fi

    done
done
