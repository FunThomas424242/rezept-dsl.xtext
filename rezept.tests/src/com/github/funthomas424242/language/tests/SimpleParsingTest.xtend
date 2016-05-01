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
			Rezeptsammlung Anhaltinische#Küche {
			    Titel: "Kochbuch des Mittelalters".
			}
		'''.parse
		assertTrue(model.element.booleanValue)
	}
	
	@Test def void testParseValidRezeptliste() {
		val model = '''
			Rezeptliste Mittagsgerichte ;
			Rezept Bratkartoffeln {
			    Titel : "Bratkartoffeln mit Ei" . 
			}
		'''.parse
		assertTrue(model.element.booleanValue)
	}
	
	@Test def void testParseValidProduktliste() {
		val model = '''
			Produktliste Aldi.Süd ; 
			
			Produkt Kaffee 
			{ Verpackung Tüte .
			    
			}
		'''.parse
		assertTrue(model.element.booleanValue)
	}
}
