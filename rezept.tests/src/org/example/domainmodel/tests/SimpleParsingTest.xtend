package org.example.domainmodel.tests

import com.google.inject.Inject
import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.junit4.util.ParseHelper
import org.junit.Test
import org.junit.runner.RunWith

import static org.junit.Assert.*
import org.example.domainmodel.DomainmodelInjectorProvider
import org.example.domainmodel.domainmodel.Domainmodel

@RunWith(XtextRunner)
@InjectWith(DomainmodelInjectorProvider)
class SimpleParsingTest {
	
	@Inject extension ParseHelper<Domainmodel>
	
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