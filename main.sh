#!/bin/bash

pdf="$1"
! test -f "$pdf" && echo 'le script doit être appelé avec en argument le nom du fichier pdf ex: ./main.sh fichier.pdf' && exit 1

# La commande suivante n'a besoin d'être executée qu'une seule fois, il faudra la commenter ensuite
sh pdf2svg.sh "$pdf"

# Quelques dépendances pour la suite :
# sudo apt-get install libxml2-dev libxslt1-dev python2.7-dev

## créer un environnement avec virtualenv
# Commencer par installer setuptools https://pypi.python.org/pypi/setuptools#installation-instructions
# Installer virtualenv : 
# sudo easy_install virtualenv
# se placer dans un dossier pyenv par exemple et faire : 
# virtualenv pdfparse
# cela crée l'environnement pdfparse dans le dossier pyenv
# activer l'environnement : 
# source /chemin/vers/pyenv/pdfparse/bin/activate
# Installer les dépendances propres à l'environnement :
# pip install beautifulsoup4
# pip install lxml
# deactivate

# à adapter suivant le dossier d'installation de l'environnement :
source ~/pyenv/pdfparse/bin/activate

> mp.csv

for file in $(find ./ -name "*.svg") ; do echo "$file"; python parse.py $file >> mp.csv ; done
