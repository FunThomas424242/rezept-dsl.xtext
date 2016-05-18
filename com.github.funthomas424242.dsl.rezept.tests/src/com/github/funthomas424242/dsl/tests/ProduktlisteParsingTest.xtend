package com.github.funthomas424242.dsl.tests

import com.github.funthomas424242.dsl.rezept.Rezeptdatei
import com.github.funthomas424242.dsl.tests.RezeptInjectorProvider
import com.google.inject.Inject
import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.junit4.util.ParseHelper
import org.junit.Test
import org.junit.runner.RunWith

import static org.junit.Assert.*

@RunWith(XtextRunner)
@InjectWith(RezeptInjectorProvider)
class ProduktlisteParsingTest {
	
	@Inject extension ParseHelper<Rezeptdatei>
	
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
		assertEquals(21, model.rezept.produkte.rezepte.size);
	}
}
