package com.github.funthomas424242.language.generator

import com.github.funthomas424242.language.rezept.RezeptbuchProjekt
import com.github.funthomas424242.language.rezept.Rezeptdatei
import org.eclipse.emf.common.util.URI
import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.emf.ecore.resource.ResourceSet
import org.eclipse.xtext.generator.IFileSystemAccess

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class BookGenerator {
	

	def static createBookContent(IFileSystemAccess fsa,RezeptbuchProjekt project) '''
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
		«val Rezeptdatei rezeptdatei = resourceToEObject(openImport(imp.eResource, imp.importURI)) as Rezeptdatei»
		«val importIndex = project.buch.imports.indexOf(imp)»
		«PartGenerator.createPart(fsa,project,rezeptdatei.rezept.rezepte,importIndex)»
	«ENDFOR»
	
	«AnhangLizenzGenerator.createLizenzAnhang(fsa,project)»
	'''
	
	private def static EObject resourceToEObject(Resource resource){
		return resource?.allContents?.head;
	}
	
	private def static Resource openImport(Resource contextResource, String importedURIAsString){
		val URI contextURI=contextResource?.getURI
		val URI importedURI=URI?.createURI(importedURIAsString)
		val URI resolvedURI=importedURI?.resolve(contextURI)
		
		val ResourceSet contextResourceSet = contextResource?.resourceSet
		val Resource resource = contextResourceSet?.getResource(resolvedURI, true)
		return resource
	}
	
}
