package com.github.funthomas424242.dsl.generator

import com.github.funthomas424242.dsl.rezept.RezeptbuchProjekt
import com.github.funthomas424242.dsl.rezept.Rezeptdatei
import org.eclipse.xtext.generator.IFileSystemAccess
import com.github.funthomas424242.dsl.rezept.BuchBeschreibung

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class BookGenerator {

	def static CharSequence createBookContent(IFileSystemAccess fsa, RezeptbuchProjekt project)	'''
<?xml version="1.0" encoding="UTF-8"?>
	«createXmlHeader()»
		
		<info>
		    <title>«project.buch.titel»</title>
		
			<authorgroup>
			«FOR autor : project.buch.autoren»
				<author>
				<personname>
				 	  <firstname>«autor.vorname»</firstname>
				 	  <surname>«autor.nachname»</surname>
				</personname>
				«IF autor.organisationsName!=null »
					<affiliation>
						<org>
							   	<orgname>«autor.organisationsName»</orgname>
						</org>
					</affiliation>
				«ENDIF»
				<contrib>«autor.modifikationsNotiz»</contrib>
				</author>
			«ENDFOR»
			</authorgroup>
		
			<pubdate>«Helper.convertDateToDefaultLocale(project.buch.datumPublished)»</pubdate>
			«IF project.buch.lizenz!=null»
				<legalnotice><para>«project.buch.lizenz.hinweis»</para></legalnotice>
			«ENDIF» 	
		</info>
		«IF project.buch.vorwort != null»
			«createVorwort(project.buch)»	
		«ENDIF»
		
		<toc/>
		
		«FOR imp : project.buch.imports»
			«val Rezeptdatei rezeptdatei = Helper.resourceToEObject(Helper.openImport(imp.eResource, imp.importURI)) as Rezeptdatei»
			«val importIndex = project.buch.imports.indexOf(imp)»
			«PartGenerator.createPart(fsa,project,rezeptdatei.rezept.rezepte,importIndex)»
		«ENDFOR»
		
		«AnhangLizenzGenerator.createLizenzAnhang(fsa,project)»
		
	'''
	
	def static createXmlHeader() '''
	<book version="5.0"
		  lang="de" 
		     xmlns="http://docbook.org/ns/docbook"
		     xmlns:xlink="http://www.w3.org/1999/xlink"
		     xmlns:xi="http://www.w3.org/2001/XInclude">	

	'''
	
	def static createVorwort(BuchBeschreibung buch) '''
		<preface>
			<title>Vorwort</title>
		
		    <para>«buch.vorwort»</para>
		
				«IF buch.absatz != null»
					«FOR absatz : buch.absatz»
						«IF absatz.titel != null»
							<para>«absatz.text»</para>
						«ELSE»
							<formalpara><title>«absatz.titel»</title>
							<para>«absatz.text»</para>
							</formalpara>
						«ENDIF»
					«ENDFOR»			
				«ENDIF»
		</preface>
	'''

}
