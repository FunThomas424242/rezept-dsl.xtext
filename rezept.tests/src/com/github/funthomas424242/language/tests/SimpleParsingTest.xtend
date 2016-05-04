package com.github.funthomas424242.language.tests

import com.github.funthomas424242.language.RezeptInjectorProvider
import com.github.funthomas424242.language.rezept.Rezept
import com.google.inject.Inject
import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.junit4.util.ParseHelper
import org.junit.Test
import org.junit.runner.RunWith

import static org.junit.Assert.*

@RunWith(XtextRunner)
@InjectWith(RezeptInjectorProvider)
class SimpleParsingTest {
	
	@Inject extension ParseHelper<Rezept>
	
	@Test def void testParseValidBuch() {
		val model = '''
			RezeptSammlung{
			    groupId ="rezepte" ;
			    artifactId = "kochbuch" ;
			    version = "1.0-SNAPSHOT" ;
			    Media Folder: "src/_fotos";
			    siteURL="http://funthomas424242.github.io/rezeptbuch";
			}
			Buch{
			    import rezepte "./backen/Plätzchen.rezept";
			    import rezepte "./backen/Pudding.rezept";
			    import rezepte "./backen/Glasuren.rezept"; 
			    import rezepte "./backen/Kuchen.rezept";
			    import rezepte "./fruehstueck/FrühstücksIdeen.rezept";
			    import rezepte "./mittagsgerichte/Asiatisch.rezept";
			    import rezepte "./mittagsgerichte/Auflaeufe.rezept";
			    import rezepte "./mittagsgerichte/Pizzas.rezept";
			    import rezepte "./mittagsgerichte/TopfUndPfanne.rezept";
			    import rezepte "./mittagsgerichte/Nudeln.rezept";
			    import rezepte "./mittagsgerichte/DDR.rezept";
			    //import rezepte "./mittagsgerichte/Vegetarisch.rezept";
			    import rezepte "./Serien/BernburgerRezepte.rezept";
			    //import rezepte "./Serien/Strassenkreuzer.rezept";
			    
			    Titel: "Freies Open Source Kochbuch";
			    Autor: {Vorname: "Sylvia" Nachname: "Schubert" Organisation: "Ich koche einfach gern" ModifikationsNotiz: "2012 Initiale Erstellung"}
			    Autor: {Vorname: "Thomas" Nachname: "Schubert" Organisation: "Fellow der Free Software Foundation Europe" ModifikationsNotiz: "2012 Initiale Erstellung"} 
			    Vorwort: 
			    "Herzlich Willkommen beim möglicherweise ersten freien Open Source Kochbuch der Welt in dem es nur um Rezepte geht. Das 
			    Kochbuch versteht sich als Fortsetzung des freien Kochbuches der Wikibooks welches Sie im Netz unter
			    https://de.wikibooks.org/wiki/Kochbuch finden können. Die ursprüngliche Idee war die Rezepte im Kochbuch von Wikibooks
			    abzulegen aber leider ist eine umfangreiche Rezeptsammlung nicht das Ziel der dortigen Community (Betrachten Sie dazu folgenden
			    Ausschnitt aus dem Leitfanden der Wikibooks:
			    https://de.wikibooks.org/wiki/Kochbuch/_Projektideen#Was_sollte_das_Kochbuch_nicht_sein.3F). Somit wurde entschieden ein
			    separates Projekt ins Leben zu rufen welches sich nicht um die Grundlagen des Kochens oder der Bestimmung zugehöriger Begriffe
			    zu kümmern sondern in dem es ausschließlich um die Ablage von Rezepten geht. 
			    </para>
			    <para>
			    Wir beglückwünschen Sie herzlich dazu, dass Sie sich für die Lektüre dieses Kochbuches entschieden haben. Sie halten mit
			    dem Produkt eine Sammlung von Rezepten in den Händen (oder betrachten diese am Bildschirm) welche viele Menschen in ihrer 
			    Freizeit zusammengetragen, sortiert, recherchiert, bearbeitet, ausprobiert und letztlich veröffentlicht haben. Alle Beteiligten
			    haben nach besten Wissen und Gewissen an der Erstellung des Buches gearbeitet und versucht dieses ohne Verletzung von Urheber-
			    oder Markenrechten zu erstellen. Die Begriffe freies Open Source Kochbuch werden im Abschnitt 
			    <emphasis>Rechtliches</emphasis> erläutert.
			    </para>
			    <para>
			    Vielleicht können Sie sich noch an Zeiten erinnern in denen Sie selbst in den Kindergarten gegangen sind und Lieder gesungen
			    haben. Die Erzieherin besaß ein Buch mit Kinderlieder und hatte bereits im Vorfeld die zu singenden Lieder kopiert. Jedes 
			    Kind bekam ein kopiertes Blatt und konnte somit das Lied in der Gruppe mitsingen. Was Sie möglicherweise nicht wissen ist, 
			    dass die Kindergrippen, Kindergärten und Schulen genau für das Kopieren dieser Liedtexte in Deutschland Geld an die GEMA 
			    bezahlen müssen. Es ist eine Pauschale welche die GEMA erhebt, unabhängig davon ob die betreffende Einrichtung tatsächlich 
			    Liedtexte kopiert! 
			    </para>
			    <para>
			    Nun kann man meinen bei Lieder sei es ja etwas anderes aber bei Rezepten ist das ja kein Problem. Doch in Wirtschaftskrisen
			    werden naturgemäß die Unternehmen nicht müde nach neuen Finanzierungsquellen zu suchen. Meist finden sich dann hier und dort 
			    noch ein paar Dinge bei denen sich eine Firma fragt warum sie dafür eigentlich kein Geld verlangen darf. So könnte dies auch
			    mit Koch- und Backrezepten passieren. Dann geht Ihr Kind in die Schule zum Kochunterricht und zu Hause kocht es das Rezept 
			    nach. Damit die Eltern es auch einmal kochen können schreibt das Kind es auf und uuuuppppps schon ist es passiert. Dann werden
			    vielleicht Gebühren fällig oder Ihr Kind bekommt ein Eintrag ins Führungszeugnis, denn es hat möglicherweise ein geschütztes
			    Rezept ohne Einverständnis des Urhebers weitergegeben und gleich an 2 Leute! Gut soweit ist es noch nicht aber wie gesagt in 
			    Wirtschaftskrisen werden Firmen unter dem Schutz der Regierung erfinderisch. Wenn die Großeltern den Kindern die Rezepte nicht 
			    mehr weiter geben dürfen weil diese auf Grund existierender Bücher geschütz wurden, werden wir Zeiten erleben in denen die Armen
			    nicht nur keine Bildung mehr bekommen sondern auch nichts mehr zu Essen haben!  
			    </para>
			    <para>
			    Um genau einer solchen möglichen zukünftigen Entwicklung entgegen zu wirken wurde diese Kochbuch erstellt und auch in Zukunft
			    stets fortgeschrieben werden. Wenn Sie möchten, können Sie selbst auch daran mitarbeiten. Wie das geht erfahren Sie auf den 
			    folgenden Seiten. Doch nun wünschen wir Ihnen zunächst viel Spaß beim Kochen.
			    "
			    Absatz: ==Rechtliches==
			    "Zunächst soll kurz erläutert werden was das überhaupt sein soll ein freies Open Source Kochbuch.
			    Open Source ist schnell erklärt. Das Buch bzw. die Rezepte müssen zunächst in einer fachspezifischen Sprache (genannt rezept)
			    beschrieben werden. Die Eingabe der Texte in dieser Sprache ermöglicht ein Computerprogramm (genannt Editor). 
			    Der Programmkode (also die Vorschrift wie man den Editor nachbauen kann) für dieses Programm ist freizugänglich und kann somit 
			    von jeder Person eingesehen werden um beispielsweise Fehler zu erkennen oder Verbesserungen vorzuschlagen. 
			    Ein weiteres Computerprogramm baut dann aus den beschriebenen Rezepten ein Buch in diversen Formaten (pdf, webhelp, html, ...).
			    Auch der Programmkode dieses Programmes ist jedermann frei zugänglich. Das versteht man unter Open Source."
			    Absatz: ==test==
			    "Frei steht hier für das Ziel im Kochbuch nur Rezepte zu veröffentlichen die von jedermann kopiert, verändert und
			    weitergegeben werden dürfen.
			    Dieses Ziel ist relativ einfach zu erreichen, da aktuell Rezepte nicht so strengen Urheberrechten unterliegen wie beispielsweise
			    musikalische Werke. Das liegt an der geringen Schöpfungshöhe von Rezepten. Generell unterscheidet der Gesetzgeber zwischen
			    technischen und schöpferischen Leistungen. Technische Leistungen werden über Patente geschützt. Schöpferische Leistungen
			    können möglicherweise ein Werk darstellen. Werke im Sinne des Gesetzes können nur eigene geistige Schöpfungen sein. Damit etwas den
			    Status eines Werkes erhält muss dann jedoch noch eine bestimmte Schöpfungshöhe erreicht werden, diese ist bei
			    Koch- und Backrezpten allgemein nicht gegeben. Jedenfalls heute nicht und später sind die Rezepte ja durch die Veröffentlichung des
			    vorliegenden Buches geschützt (Absatz: Schutz der Freiheit des Kochbuches)." 
			    Absatz:
			    "Eine Ausnahme von vorgenannten bilden besondere Rezepturen welche beispielsweise nicht allgemein bekannt sind. Dazu zählen 
			    beispielsweise die genaue Zusammensetzung von Backmischungen wie auch völlig neuartige Rezepturen. Diese werden dann allgemein
			    über Patente geschützt. Die sorgfältige Ausführung und das gewohnte Aroma oder die gewohnte Qualität von Produkten wird 
			    in der Regel über Marken geschützt.
			    </para>
			    <para>
			    Beim Erstellen des Kochbuches können also durchaus Rezepte aus dem Internet oder von Anderen benutzt werden. Hierbei ist jedoch
			    zu beachten:
			    <itemizedlist>
			    <listitem><para>Die Quelle oder Herkunft des Rezeptes ist zu benennen.</para></listitem>
			    <listitem><para>Der Text des Originalrezeptes ist zu verwerfen und alles mit eigenen Worten zu beschreiben.</para></listitem>
			    <listitem><para>Nicht verwendbar sind Rezepte bei denen der Urheber explizit das Kopieren, Verändern 
			    oder die Weitergabe untersagt.</para></listitem>
			    <listitem><para>Es darf kein Markenname benutzt werden und gegen kein Markenrecht verstoßen werden.</para></listitem>
			    <listitem><para>Bei Verweisen auf Marken beispielsweise Produktempfehlungen ist der Markenname zu kennzeichen.</para></listitem>
			    </itemizedlist>
			    "
			    Absatz: ==Schutz der Freiheit des Kochbuches==
			    "Bei einem freien Kochbuch geht man eigentlich davon aus, dass jede Lizenz die Freiheit schon beschneidet. Doch auch die
			    Freiheit des Kochbuches muss geschützt werden! Ein Beispiel: Wir veröffentlichen dieses Kochbuch weltweit frei. Jeder darf
			    es kopieren, verändern und weitergeben. Letztlich gelangt es in die Hände eines Startup Unternehmens im Catering Bereich.
			    Spontan startet das Unternehmen sein Catering mit einem Angebot welches nur aus Rezepten aus diesem Kochbuch besteht.
			    Nach einer Weile stellt das Unternehmen fest, dass sich mit diesen Rezepten ein riesiger Umsatz machen lässt. Nun lässt es
			    genau diese Rezepte patentieren in Staaten in denen das möglich ist. Damit kann es sicherstellen, dass die Konkurrenz andere
			    Rezepte kochen muss oder aber Gebühren zu entrichten hat. Leider gilt das aber nicht nur für die Konkurrenz sondern auch für
			    uns die wir das Kochbuch als Erste ins Netz gestellt haben. Wir bekommen also einen Mahnbescheid (in der Regel von mehreren
			    Tausend Euro) und müssen zahlen nebst Unterlassungsklage. Das ist natürlich nicht der Sinn der Freiheit die wir unserem
			    Kochbuch geben wollen! Daher schützen wir das Kochbuch mit einer Lizenz, der GFDL (GNU Free Documentation License) ab Version 
			    1.3. Diese sichert allen Nutzern die Rechte zum Kopieren, Verändern und Verteilen und sogar zur kommerziellen Nutzung. 
			    Mit einer ganz wichtigen Einschränkung - das Buch darf nur unter der gleichen Lizenz kopiert, bearbeitet und weitergegeben 
			    werden. Damit brauchen weder wir die Autoren noch Sie die Nutzer Angst vor Abmahnungen haben. 
			    Ja, möglicherweise erscheinen einige rechtliche Vorkehrungen zu kompliziert und überflüssig aber nur mit siesen sind wir
			    auf der sicheren Seite.
			    "
			    Absatz: ==Rücksicht auf andere soziale Vereine==
			    "Ursprünglich sollte dieses Kochbuch auch Rezepte aus dem Magazin Strassenkreuzer enthalten. Es handelt sich um ein Magazin
			    welches von Arbeits- oder Obdachlosen zusammengestellt und vertrieben wird. Die 'Verkäufer' stehen bei jeder Witterung
			    und versuchen die Magazine zu verkaufen für ein wenig Geld. Sie dürfen die Magazine nicht bewerben und keine Passanten 
			    ansprechen im Gegensatz zu Firmen die uns täglich ungefragt mit Werbung nötigen. Auf den letzten Seiten im Magazin befindet
			    sich meist ein sehr gutes Rezept zum Nachkochen. Rechtlich wäre es kein Problem gewesen diese Rezepte hier ins Kochbuch in 
			    veränderter Form und mit Quellennachweis aufzunehmen. Tatsächlich existieren auch bereits Rezepte aus dem Strassenkreuzer 
			    welche in die Fachsprache <emphasis>rezept</emphasis> übertragen wurden. Diese wurden jedoch absichtlich nicht mit in die 
			    Veröffentlichung eingebunden um nicht den sozial armen Schichten in Deutschland auch noch weitere Einschnitte in ihre
			    Lebensgrundlage zu zu muten. 
			    Dies geschieht also in voller Absicht. Da die Rezepte aus dem Strassenkreuzer aber wirklich köstlich sind sei der Leser auf 
			    den Kauf des Magazins oder der Online Ausgabe unter strassenkreuzer.de verwiesen. Außerdem möchten wir auch zukünftigen 
			    Editoren ans Herz legen, keine Konkurrenz zu sozialen Vereinen aufzubauen.
			        
			    Vielen Dank Thomas Schubert (FunThomas424242) Initiator des Projektes.
			    "
			    
			    Absatz: == Nachruf ==
			    "An dieser Stelle ein herzliches Beleid an alle Leser und Bekannten von Jochen Banzhaf. Jochen schrieb für das Sozialmagazin
			    'Strassenkreuzer' unter der Rubrik 'Kochen mit Jochen' bis zu seinem frühen Tod im Mai 2013. Seine Rezepte sind über die 
			    Onlinepräzens des Magazins verfügbar unter: <link
			    xlink:href='http://www.strassenkreuzer.info/das-sozialmagazin/kochen-mit-jochen.html' xlink:show='new'>
			    http://www.strassenkreuzer.info/das-sozialmagazin/kochen-mit-jochen.html</link> 
			    "
			    
			    
			    Lizenzhinweis: "GNU Free Documentation License (GFDL) v1.3 und folgende Versionen"
			    Veröffentlicht am: 16.01.2013.
			}
		'''.parse
		assertEquals("kochbuch",model.projectBeschreibung.artifactId)
		assertEquals(6,model.projectBeschreibung.buch.absatz.size)
	}
	
	@Test def void testParseValidRezeptliste() {
		val model = '''
			Rezeptliste "DDR Gerichte" ; 
			import produkte "../Commons/ProdukteEdeka.rezept" ;
			
			
			
			Rezept "Jägerschnitzel (DDR)" {
			
			Titel: "Jägerschnitzel".
			Untertitel: "nach DDR Art".
			Kategorie: "Kochen".
			Quelle: übernommen "verändert" aus "http://www.kochbar.de/rezept/369345/altes-DDR-Rezept-Jaegerschnitzel.html".
			Ausreichend für 2 Personen.
			Letzte Änderung: 05.07.2014.
			Tag: "Nudeln".
			Tag: "Jagdwurst".
			Tag: "Tomate".
			
			ProduktRef: "Braten Fond" Menge: "1" mal.
			
			Zutat: "Spirelli (Fussili)" Menge: "1" "Tüte(n)".
			Zutat: "Jagdwurst" Menge: "2" "Scheiben".
			Zutat: "Eier" Menge: "2" "Stück".
			Zutat: "Paniermehl" Menge: "1" "Tüte(n)".
			Zutat: "Tomaten passiert" Menge: "1" "Dose".
			Zutat: "Tomatenmark" Menge: "5" "Esslöffel".
			Zutat: "Zwiebeln" Menge: "3" "Stück".
			Zutat: "Braten Fond" Menge: "200" "ml".
			Zutat: "Sanella" "nach Bedarf".
			
			Aktion: "Die Zwiebeln in feine Stücke hacken."
			Aktion: "Nudeln im Salzwasser zum Kochen aufsetzen."
			Aktion: "Für die Sosse die Zwiebeln in einen Topf geben und mit Sanella goldgelb braten."
			Aktion: "Die Zwiebeln mit den passierten Tomaten ablöschen, den Bratenfond unterrühren,
			 das Tomatenmark zugeben und aufkochen."
			Aktion: "Fleischwurst in die Pfanne geben und braten bis sie eine gold braune
			Färbung annimmt."
			Aktion: "Die Sosse mit Basilikum würzen und auf niedrigster Stufe köcheln lassen."
			Aktion: "Die Jadwurstscheiben panieren und beidseitig braten und servieren 
			(Sie sollten zeitgleich mit den Nudeln fertig werden)."
			--Zusatzinformationen--
			
			Bild: URL: "https://farm6.staticflickr.com/5513/10244038744_47054da933_b_d.jpg" 
			Text: "Vorbereitung"
			Lizenz: "Creative Commons Namensnennung - Weitergabe unter gleichen Bedingungen 2.0 Generic (CC BY-SA 2.0)"
			Urheber: "Huluvu424242 (Thomas Schubert)".
			
			Bild: URL: "https://farm8.staticflickr.com/7438/10244134525_a2e714e832_b_d.jpg" 
			Text: "Panieren"
			Lizenz: "Creative Commons Namensnennung - Weitergabe unter gleichen Bedingungen 2.0 Generic (CC BY-SA 2.0)"
			Urheber: "Huluvu424242 (Thomas Schubert)".
			
			Bild: URL: "https://farm4.staticflickr.com/3803/10244237373_2b3ac9d171_b_d.jpg" 
			Text: "Gerade angesetzt"
			Lizenz: "Creative Commons Namensnennung - Weitergabe unter gleichen Bedingungen 2.0 Generic (CC BY-SA 2.0)"
			Urheber: "Huluvu424242 (Thomas Schubert)".
			
			Bild: URL: "https://farm9.staticflickr.com/8120/10244048554_91d6230590_b_d.jpg" 
			Text: "Fast fertig"
			Lizenz: "Creative Commons Namensnennung - Weitergabe unter gleichen Bedingungen 2.0 Generic (CC BY-SA 2.0)"
			Urheber: "Huluvu424242 (Thomas Schubert)".
			
			Bild: URL: "https://farm6.staticflickr.com/5495/10244139385_9066ebb4e8_b_d.jpg" 
			Text: "Servieren"
			Lizenz: "Creative Commons Namensnennung - Weitergabe unter gleichen Bedingungen 2.0 Generic (CC BY-SA 2.0)"
			Urheber: "Huluvu424242 (Thomas Schubert)".
			
			}
			
			Rezept "Eisbein (DDR)" {
			
			Titel: "Eisbein".
			Untertitel: "nach DDR Art".
			Kategorie: "Kochen".
			Quelle: übernommen "verändert" aus "http://www.kochbar.de/rezept/361082/Eisbein-gekocht.html".
			Ausreichend für 2 Personen.
			Letzte Änderung: 20.02.2016.
			Tag: "Schwein".
			Tag: "Fett".
			
			Zutat: "Eisbein" Menge: "2" "Stück".
			Zutat: "Möhren" Menge: "1" "Stück".
			Zutat: "Zwiebel" Menge: "1" "Stück".
			Zutat: "Lorbeerblätter" Menge: "5" "Stück".
			Zutat: "Piment" Menge: "5" "Stück".
			Zutat: "Wachholderbeeren" Menge: "5" "Stück".
			Zutat: "Salz" "nach Bedarf".
			Zutat: "Sauerkraut" Menge: "1" "kg".
			Zutat: "Kartoffeln" Menge: "1" "kg".
			
			Aktion: "Eisbeine in einen Topf geben und mit 2 Liter Wasser auffüllen."
			Aktion: "Zwiebel und Möhren klein schneiden in den Topf geben."
			Aktion: "Gewürze hinzufügen und kräftig salzen."
			Aktion: "Alles zusammen erhitzen und so lange kochen bis sich das Fleisch löst (ca. 3 Stunden)."
			Aktion: "Das Sauerkraut ca. 10 Minuten auf kleiner Flamme erwärmen."
			Aktion: "Kartoffeln kochen."
			Aktion: "Sehr heiß mit viel Senf servieren."
			--Zusatzinformationen--
			
			
			}
		'''.parse
		assertEquals(2,model.rezeptListe.rezepte.size)
	}
	
	@Test def void testParseValidProduktliste() {
		val model = '''
			Produktliste "Edeka" ;
			
			
			// Sossen
			Produkt "Braten Fond"{
			Verpackung: "Glas".
			Menge: "400" "ml".
			Letzte Änderung: 04.07.2014.
			}
			
			//Getreide und Korn
			Produkt "Mehl"{
			Verpackung: "Packung".
			Menge: "500" "g".
			Letzte Änderung: 04.08.2012.
			}
			
			
			// Mehlprodukte
			Produkt "Spirelli (Fussili)"{
			Verpackung: "Tüte".
			Menge: "1" "Tüte(n)".
			Letzte Änderung: 05.07.2014.
			}
			
			
			// Fleisch
			
			Produkt "Schweinefleisch" {
			Verpackung: "Packung".
			Menge: "1" "g".
			Letzte Änderung: 01.01.2012.
			}
			
			Produkt "Bauchspeck vom Schwein"{
			Menge: "300" "g".
			EAN: "4-311596-424221".
			Letzte Änderung: 04.03.2012.
			}
			
			Produkt "5 Minutensteaks vom Schwein" {
			Menge: "400" "g". 
			EAN: "2-399859-003224".
			Preis: "3.22" "Euro".
			Händler: "Edeka".
			Letzte Änderung: 04.03.2012.
			}
			
			
			// Gemüse
			
			Produkt "Kartoffeln festkochend"{
			Menge: "2.5" "kg".
			Letzte Änderung: 30.12.2012.
			}
			
			Produkt "Zwiebeln"{
			Verpackung: "Netz".
			Menge: "1.0" "kg".
			Letzte Änderung: 30.12.2012.
			}
			
			// Milchprodukte
			
			Produkt "Milch"{
			Verpackung: "Packung".
			Menge: "1" "L".
			Letzte Änderung: 01.01.2012.
			}
			
			Produkt "Emmentaler in Scheiben" {
			Menge: "200" "g".
			EAN: "4-016993-103778".
			Händler: "Edeka".
			Letzte Änderung: 04.03.2012.
			}
			
			Produkt "Emmentaler Reibekäse"{
			Menge: "200" "g".
			Letzte Änderung: 04.08.2012.
			}
			
			Produkt "Sanella"{
			Menge: "500" "g".
			Letzte Änderung: 04.08.2012.
			}
			
			//Gewürze
			
			Produkt "Salz"{
			Verpackung: "Packung".
			Menge: "500" "g".
			Letzte Änderung: 01.01.2012.
			}
			
			
			
			//Backzutaten
			
			Produkt "Sanella"{
			Verpackung: "Becher".
			Menge: "500" "g".
			Letzte Änderung: 04.07.2014.
			}
			
			Produkt "Kakao"{
			Verpackung: "Packung".
			Menge: "1" "g".
			Letzte Änderung: 01.01.2012.
			}
			
			Produkt "Stärke"{
			Verpackung: "Packung".
			Menge: "250" "g".
			Letzte Änderung: 01.01.2012.
			}
			
			Produkt "Traubenzucker"{
			Verpackung: "Packung".
			Menge: "1" "g".
			Letzte Änderung: 01.01.2012.
			}
			
			Produkt  "Vanillinzucker" {
			Verpackung: "Päckchen".
			Menge: "1" "Päckchen".
			Letzte Änderung: 29.06.2014.
			}
			
			Produkt  "Rum Rosinen" {
			Verpackung: "Päckchen".
			Menge: "1" "Päckchen".
			Letzte Änderung: 29.06.2014.
			}
			
			Produkt  "Eier" {
			Verpackung: "Packung".
			Menge: "10" "Stück".
			Letzte Änderung: 01.01.2012.
			}
			
			//Bakterien, Pilze, Sporen
			
			Produkt "Hefeteig Garant"{
			Verpackung: "Päckchen".
			Menge: "1" "Päckchen".
			Letzte Änderung: 29.06.2014.
			}

		'''.parse
		assertNotNull(model.produktListe)
	}
}
