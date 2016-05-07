package com.github.funthomas424242.language.tests

import com.github.funthomas424242.language.RezeptInjectorProvider
import com.github.funthomas424242.language.rezept.Rezeptdatei
import com.google.inject.Inject
import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.junit4.util.ParseHelper
import org.junit.Test
import org.junit.runner.RunWith

import static org.junit.Assert.*

@RunWith(XtextRunner)
@InjectWith(RezeptInjectorProvider)
class RezeptlisteParsingTest {
	
	@Inject extension ParseHelper<Rezeptdatei>
	
	
	
	@Test def void testParseValidRezeptliste() {
		val model = '''
			Rezeptliste "DDR Gerichte" ; 
			import produkte "../Commons/ProdukteEdeka.rezept" alias "Edeka" ;
			
			
			
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
		assertEquals(2,model.rezept.rezepte.rezepte.size)
	}
	
	
}
