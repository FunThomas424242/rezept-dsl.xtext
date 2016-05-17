package com.github.funthomas424242.language.generator

import com.github.funthomas424242.language.rezept.Bild
import com.github.funthomas424242.language.rezept.Internetpfad
import com.github.funthomas424242.language.rezept.Lokalerpfad
import org.eclipse.emf.common.util.URI
import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.emf.ecore.resource.ResourceSet

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class Helper {

	def static stripQuotes(String text) {
		return text.substring(1, text.length - 1)
	}

	def static getFileRef(Bild bild) {

		if (bild.ablageort instanceof Internetpfad) {
			val ablage = bild.ablageort as Internetpfad;
			return ablage.url
		} else {
			val ablage = bild.ablageort as Lokalerpfad;
			return ablage.fileName
		}
	}
	
	def static EObject resourceToEObject(Resource resource){
		return resource?.allContents?.head;
	}
	
	def static Resource openImport(Resource contextResource, String importedURIAsString){
		val URI contextURI=contextResource?.getURI
		val URI importedURI=URI?.createURI(importedURIAsString)
		val URI resolvedURI=importedURI?.resolve(contextURI)
		
		val ResourceSet contextResourceSet = contextResource?.resourceSet
		val Resource resource = contextResourceSet?.getResource(resolvedURI, true)
		return resource
	}
	
	def static String convertDateToDefaultLocale( String datum ){
		val String yyyy = datum.substring(6,10)
		val String mm   = datum.substring(3,5)
		val String dd   = datum.substring(0,2)
		return (yyyy + '-' + mm + '-' + dd)
	}
	
}
