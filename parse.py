#! /usr/bin/env python
# -*- coding: utf8 -*-
import sys, os, re
from bs4 import BeautifulSoup
# La doc est là : http://www.crummy.com/software/BeautifulSoup/bs4/doc/

def cellsToCsv(cells):
  line = ''
  for cell in cells:
    line = line+cells[cell]+';'
  return line.rstrip(';')

doc = open(sys.argv[1], "r")
svg = doc.read()
soup = BeautifulSoup(svg)

ok = False
cellules = {}
i = 0

groupes = soup.find_all('g')

for g in groupes:
  texte = g.get_text().strip()
  if (texte != ''):
    # On a du texte, il suffit maintenant d'identifier les récurrences en examinant la structure du pdf original
    # Attention : les transformations en svg ne sont que rarement optimales, la plupart du temps il faudra corriger à la main dans le csv
    
    # Types de marchés MARCHES DE FOURNITURES
    if(re.match("^MARCHES DE", texte)):
      typemarche = re.sub('MARCHES DE ', '', texte)
      
    elif(ok):
      # la dernière cellule est un code postal
      if(re.match("[0-9]{5}", texte)):
        cellules[i] = texte
        cellules[i+1] = typemarche
        print(cellsToCsv(cellules))
        i = 0
      else:
        cellules[i] = texte
        i+=1
    
    # Texte précédant le début des lignes utiles du tableau
    if(texte == 'Code postal'):
      ok = True

print(cellsToCsv(cellules))
