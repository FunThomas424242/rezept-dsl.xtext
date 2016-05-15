package com.github.funthomas424242.language.generator

import com.github.funthomas424242.language.rezept.Bild
import com.github.funthomas424242.language.rezept.Internetpfad
import com.github.funthomas424242.language.rezept.Lokalerpfad

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
}
