package com.github.funthomas424242.language.rezept.tests

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
	
	@Test def void testParse() {
		val model = '''
			package mypack {
			    import toimport
			    
			   datatype Kennzeichen  
			   datatype Name
			   
			   entity Fahrzeug { 
			       hersteller:  Name
			   }
			   
			   entity Auto extends Fahrzeug {
			       nummer:Kennzeichen
			       
			   }
			   
			    
			    
			}
		'''.parse
		assertEquals(1, model.elements.size)
	}
}
