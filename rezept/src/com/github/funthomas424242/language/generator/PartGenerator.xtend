package com.github.funthomas424242.language.generator

import com.github.funthomas424242.language.rezept.BenutzerTag
import com.github.funthomas424242.language.rezept.BestimmteMenge
import com.github.funthomas424242.language.rezept.DiaetTag
import com.github.funthomas424242.language.rezept.Internetpfad
import com.github.funthomas424242.language.rezept.Literaturquelle
import com.github.funthomas424242.language.rezept.Lokalerpfad
import com.github.funthomas424242.language.rezept.Personenquelle
import com.github.funthomas424242.language.rezept.RezeptBlatt
import com.github.funthomas424242.language.rezept.RezeptbuchProjekt
import com.github.funthomas424242.language.rezept.Rezeptliste
import com.github.funthomas424242.language.rezept.StoffTag
import com.github.funthomas424242.language.rezept.UnbestimmteMenge
import org.eclipse.xtext.generator.IFileSystemAccess
import com.github.funthomas424242.language.rezept.Verpackung

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class PartGenerator {

	def static createPart(IFileSystemAccess fsa, RezeptbuchProjekt project, Rezeptliste liste, int parentIndex) '''		
	<part>
	    <title>«liste.name»</title>
	    «FOR rezept : liste.rezepte»
	    	«val rezeptIndex = liste.rezepte.indexOf(rezept)»
		<xi:include href="Rezept«parentIndex+'_'+rezeptIndex».dbk" />
		«fsa.generateFile(RezeptGenerator.getDbkFileName(project, "Rezept"+parentIndex+'_'+rezeptIndex+".dbk"),
			createChapter(fsa,project,rezept, parentIndex+" "+rezeptIndex))»
		«ENDFOR»
	</part>
	'''

	def static createChapter(IFileSystemAccess fsa, RezeptbuchProjekt project, RezeptBlatt rezept,
		String rezeptIndex) '''
<?xml version="1.0" encoding="UTF-8"?>
<chapter version="5.0" xmlns="http://docbook.org/ns/docbook"
         xmlns:xlink="http://www.w3.org/1999/xlink"
         xmlns:xi="http://www.w3.org/2001/XInclude"
         xmlns:ns5="http://www.w3.org/2000/svg"
         xmlns:ns4="http://www.w3.org/1998/Math/MathML"
         xmlns:ns3="http://www.w3.org/1999/xhtml"
         xmlns:db="http://docbook.org/ns/docbook">
 
<title>«rezept.titel»</title>

<para>
	<variablelist>
	     <varlistentry>
	       <term>Tags:</term>
		<listitem>
		   	<para>
		   	«FOR tag : rezept.tags»
		«IF rezept.tags.indexOf(tag)>0»,«ENDIF»
		«IF tag instanceof BenutzerTag»
			«tag.bezeichnung»
		«ENDIF»
		«IF tag instanceof StoffTag»
			«tag.stoff»
		«ENDIF»
		«IF tag instanceof DiaetTag»
			«tag.diaet»
		«ENDIF»
	«ENDFOR»
	</para>
	</listitem>
	    </varlistentry>
	 <varlistentry>
	   <term>Quelle:</term>
	<listitem><para>
			«IF rezept.quelle==null»
				nicht angegeben
			«ELSE»
				«IF rezept.quelle instanceof Literaturquelle»
					«val literaturQuelle = rezept.quelle as Literaturquelle»
					«literaturQuelle.modifikation» übernommen aus: «literaturQuelle.beschreibung»
				«ENDIF»
				«IF rezept.quelle instanceof Personenquelle»
					«val personenQuelle = rezept.quelle as Personenquelle»
					überliefert von «personenQuelle.personenBeschreibung»
				«ENDIF»
			«ENDIF»
		</para></listitem>
		 </varlistentry>
		  </variablelist>
</para>

<formalpara>
	<title>Zutaten</title>

    <para><itemizedlist>
    «FOR zutat : rezept.zutaten»
	<listitem>
	    <para>
«IF zutat.menge instanceof UnbestimmteMenge»
	«val menge = zutat.menge as UnbestimmteMenge»	          		
		«menge.menge»
«ENDIF»
«zutat.name»
	«IF zutat.menge instanceof BestimmteMenge» 
		«val menge = zutat.menge as BestimmteMenge»
			«menge.betrag»
			«menge.einheit»
	«ENDIF»
	</para>
	    </listitem>
«ENDFOR»  
    </itemizedlist></para>
  </formalpara>

  <formalpara>
    <title>Arbeitsschritte</title>

    <para><orderedlist>
    «FOR schritt : rezept.schritte»  
<listitem>
   	<para>
«schritt.beschreibung»
 </para>
 «IF schritt.notiz != null»
 	<note>
 	 <para>
 	«schritt.notiz.text»
 	 </para>
 	</note>
 «ENDIF»
 </listitem>
«ENDFOR»
</orderedlist ></para>
«IF !rezept.notizen.nullOrEmpty»
	<formalpara>
	     <title>Hinweise</title>
	<para>
	«FOR notiz : rezept.notizen»
		<note>
		       		<para>«notiz.text»</para>
		</note>
	«ENDFOR»
	</para>
	</formalpara>
«ENDIF»
	</formalpara>

  <formalpara>
    <title>Einkaufsempfehlung</title>
	«IF rezept.produkte == null»
	<para>
		Keine verfügbar.
	</para>
«ELSE»
	<para><itemizedlist>
	«FOR produktRef : rezept.produkte»
		<listitem>
		        <para>
		«produktRef.anzahl» x
			«IF produktRef.produkt.verpackung != Verpackung.KEINEAUSWAHL»
				«produktRef.produkt.verpackung»
			«ENDIF»
			«produktRef.produkt.name» 
			«IF produktRef.produkt.menge instanceof BestimmteMenge»
				«val menge = produktRef.produkt.menge as BestimmteMenge»
				«menge.betrag» «menge.einheit»
			«ENDIF»
		</para>
		 </listitem>
	«ENDFOR»
	</itemizedlist></para>
«ENDIF»
	</formalpara>

«IF !rezept.bilder.nullOrEmpty»
<formalpara>
  <title>Bilder</title>

	<para>
	«FOR bild : rezept.bilder»
		<inlinemediaobject>		
			<alt>«bild.beschreibung»</alt>	
			      <imageobject>
				<info>
					<legalnotice><para>«bild.lizenz»</para></legalnotice>
					<author>
						<personname>
									<othername>«bild.urheber»</othername>
						</personname>
					</author>
						</info>
				<imagedata contentwidth="2in"
					«IF bild.ablageort instanceof Internetpfad»
						«val ablage = bild.ablageort as Internetpfad»
						fileref="«ablage.url»">
					«ELSE»
						«val ablage = bild.ablageort as Lokalerpfad»
						fileref="«ablage.fileName»">
					«ENDIF»
				</imagedata>
			</imageobject>
			<!-- alternative beschreibung auf rein textbasierten Systemen -->
			<textobject>
				<phrase>«bild.beschreibung»</phrase>
			</textobject>
		</inlinemediaobject>
		<footnote><para>
			<trademark class='copyright'/>
			<author>
				<personname>
					<othername>«bild.urheber»</othername>
				</personname>
			</author>
			geschützt durch: «bild.lizenz».
		</para></footnote>
	«ENDFOR»
	</para>

  </formalpara>
«ENDIF»

</chapter>
	'''
}
