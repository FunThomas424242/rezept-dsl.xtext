# 1.0.2
* epub generierung erfolgt nicht in die site
* issue #1 Diät, Stoff und Tag werden nicht mehr mit . abgeschlossen.
* 

# 1.0.1
* new groupId: com.github.funthomas424242
  to work global at bintray with a unique groupId
* distributionManagement added

# 1.0.0
* initiale Projekterstellung
* Nahe zu identischen Sprachrealisierung zum Vorgängerprojekt (EMFText Realisierung)
  https://github.com/funthomas424242/rezept-dsl
* Der neue Technologiestack besteht aus 
  ** eclispe mars als osgi umgebung
  ** java 8
  ** maven 3.3.9
  ** xtext als DSL Modellierungssprache
  ** xtend als Generatorsprache
  
## Bekannte Abweichungen zum Vorgänger Projekt 
* Die Imports wurden um eine Syntax zur Vergabe von aliase erweitert (Pflichtsyntax)
* Verpackungs- und Masseinheiten wurden erweitert bzw. Formen wie Packung auf Packung(en) geändert.
