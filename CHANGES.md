# 3.0.0 (3.0.0-SNAPSHOT, 2.1.0-SNAPSHOT, 2.0.1-SNAPSHOT)

* issue #6 umgestellt auf separate Konfigurationen
* umgestellt auf Generierung von epub3 Format
* issue #4 behoben -> Parts mit Bildern, Zitaten und Texten
* issue #8 behoben -> Details der Kapitel werden ausgegeben
* issue #2 behoben -> Details werden generiert und Stück wird weggelassen.
* issue #7 behoben -> Branding eingearbeitet



# 2.0.0 (1.0.2-SNAPSHOT)

* Diese Version bricht die Syntax API, wodurch die in Rezept abgefassten Dokumente zu ändern sind.
* epub generierung erfolgt nicht in die site
* issue #1 Diät, Stoff und Tag werden nicht mehr mit . abgeschlossen.
* Mengen werden als Nummern nicht als Strings ausgegeben.
* Mengen werden vor den Zutaten ausgegeben
* Unbestimmte Mengen werden nach den Zutaten ausgegeben
* Die Masseinheit kann ab sofort entfallen z.B. bei Zutaten 1 Stück Möhre -> 1 Möhre
* Masseinheiten und Unbestimmte Mengenangaben werden ohne Quotes im Editor eingegeben.
* tycho-versions-plugin aufgenommen um leichter ein Release bauen zu können.

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
