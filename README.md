# rezept-dsl.xtext
Realisierung der Sprache Rezept mittels einer auf Xtext basierenden DSL.

[![Build Status](https://travis-ci.org/FunThomas424242/rezept-dsl.xtext.svg?branch=master)](https://travis-ci.org/FunThomas424242/rezept-dsl.xtext)
 [![Download](https://api.bintray.com/packages/funthomas424242/eclipse-features/rezept-dsl.xtext/images/download.svg) ](https://bintray.com/funthomas424242/eclipse-features/rezept-dsl.xtext/_latestVersion)

## Nutzung
Das Feature kann in Eclipse Mars installiert werden und dann können Kochbücher oder Rezepte erstellt werden.

Eine fertig konfigurierte IDE (nebst Kochbuchprojekt) zum Download findet sich auf yatta profiles unter:
https://marketplace.yatta.de/profiles/VtG1


## Development

Wer an der Sprache für Kochbücher und Rezepte mitentwickeln möchte, der findet eine vorkonfigurierte
Entwicklungsumgebung auf yatta profiles unter:
https://marketplace.yatta.de/profiles/gyXP

## Notizen zum Releasebau

1. In der pom.xml vom parent muss das Property newVersion auf die neue Version gesetzt werden.
1. mvn clean install aufrufen (Alternativ: *mvn tycho-versions:set-version*)
1. git push -> github
1. check travis-ci build grün
1. git branch 2.0.0
1. git checkout 2.0.0
1. git push --set-upstream origin 2.0.0
1. git tag 2.0.0-RELEASE
1. git push origin tags/2.0.0-RELEASE
1. check travis-ci build grün
1. mvn deploy -> https://oss.jfrog.org/webapp/#/artifacts/browse/tree/General/oss-release-local
1. Manuell das Release von oss.jfrog.org kopieren nach bintray package: funthomas424242/eclipse-features/rezept-dsl.xtext

## Nützliche Infos im Netz

* https://christiandietrich.wordpress.com/2012/08/07/xtext-referencing-elements-of-one-dsl-from-another-dsl/
* http://download.eclipse.org/acceleo/updates/releases/3.6 (Update Site Acceleo)
* https://github.com/sbegaudeau/DSL-Scala-Generation/blob/master/plugins/org.obeonetwork.dsl.gen.scala/pom.xml (Acceleo pom.xml Beispiel)
* https://wiki.eclipse.org/Acceleo/Maven
