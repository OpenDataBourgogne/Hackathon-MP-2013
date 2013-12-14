#!/bin/bash
# by Dlareg le samedi 14 décembre 2013 pour le hackathon OpenDataBourgogne
# script pour supprimer les espaces et les majuscules des noms des fichiers PDF
# placer vos PDF dans le répertoire pdf et lancer le script
DIRECTORY="./pdf"
OIFS="$IFS"
IFS=$'\n'
for a in `find $DIRECTORY -type f -name "*.pdf"` ;do
  echo "suppression des espaces et des majuscules sur le fichier $a";
  #rename 's/\s+/_/g' $a
  b=$(echo "$a" | sed -e 's/[[:blank:]]/_/g' | tr '[:upper:]' '[:lower:]');
  if [ -e $b ];then
  echo "">/dev/null;
  else
  mv "$a" "$b";
  fi
done
IFS="$OIFS" 
