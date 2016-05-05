package com.github.funthomas424242.language.generator

import com.github.funthomas424242.language.rezept.ProjektBeschreibung
import org.eclipse.xtext.generator.IFileSystemAccess

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class BookGenerator {
	

	def static createBookContent(IFileSystemAccess fsa,ProjektBeschreibung project) '''
		<?xml version="1.0" encoding="UTF-8"?>
		<book version="5.0" xmlns="http://docbook.org/ns/docbook"
		      xmlns:xlink="http://www.w3.org/1999/xlink"
		      xmlns:xi="http://www.w3.org/2001/XInclude">
		
		<info>
		    <title>«project.buch.titel»</title>
		
			<authorgroup>
			«FOR autor : project.buch.autoren»
				<editor>
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
				</editor>
			«ENDFOR»
			</authorgroup>
	
		<pubdate>«project.buch.datumPublished»</pubdate>
		«IF project.buch.lizenz!=null»
			<legalnotice><para>«project.buch.lizenz.hinweis»</para></legalnotice>
		«ENDIF» 	
	</info>
	«IF project.buch.vorwort != null»	
		<preface>
			<title>Vorwort</title>
		
		    <para>«project.buch.vorwort»</para>

			«IF project.buch.absatz != null»
				«FOR absatz : project.buch.absatz»
					«IF absatz.titel!=null»
						<para>«absatz.text»</para>
					«ELSE»
						<formalpara><title>«absatz.titel»</title>
						<para>«absatz.text»</para>
						</formalpara>
					«ENDIF»
				«ENDFOR»			
			«ENDIF»
		</preface>
	«ENDIF»
	
	<toc/>
	
	«FOR imp : project.buch.imports»
		«val importIndex = project.buch.imports.indexOf(imp)»
		«PartGenerator.createPart(fsa,project,project.buch.imports,importIndex)»
	«ENDFOR»
	
	«AnhangLizenzGenerator.createLizenzAnhang(fsa,project)»
	'''
	
	
}
