package com.github.funthomas424242.language.generator

import com.github.funthomas424242.language.rezept.BenutzerTag
import com.github.funthomas424242.language.rezept.BestimmteMenge
import com.github.funthomas424242.language.rezept.DiaetTag
import com.github.funthomas424242.language.rezept.Literaturquelle
import com.github.funthomas424242.language.rezept.Masseinheit
import com.github.funthomas424242.language.rezept.Personenquelle
import com.github.funthomas424242.language.rezept.RezeptBlatt
import com.github.funthomas424242.language.rezept.RezeptbuchProjekt
import com.github.funthomas424242.language.rezept.Rezeptliste
import com.github.funthomas424242.language.rezept.StoffTag
import com.github.funthomas424242.language.rezept.UnbestimmteMenge
import com.github.funthomas424242.language.rezept.UnbestimmteMengenangabe
import com.github.funthomas424242.language.rezept.Verpackung
import org.eclipse.xtext.generator.IFileSystemAccess

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class PartGenerator {

	def static createPart(IFileSystemAccess fsa, RezeptbuchProjekt project, Rezeptliste liste,
		int parentIndex) '''		
		<part>
		    <title>«liste.name»</title>
		    
		    <partintro>
		    «IF liste.zitat != null»
		    <blockquote>
		    	<attribution>«liste.zitat.verfasser»</attribution>
		    	<para>
		    		«liste.zitat.text»
		    	</para>
		    </blockquote>
		    «ENDIF»
		    «IF liste.bild != null»
		    <graphic 
		    	srccredit="«liste.bild.beschreibung»" 
		    	fileref="«Helper.getFileRef(liste.bild)»"/>
		    «ENDIF»
		    «IF liste.zusammenfassung != null»
		    <para>
		    	«liste.zusammenfassung.text»
		    </para>
		    «ENDIF»
		    
		    </partintro>
		    
		    «FOR rezept : liste.rezepte»
		    	«val rezeptIndex = liste.rezepte.indexOf(rezept)»
			<xi:include href="Rezept_«parentIndex+'_'+rezeptIndex».dbk" />
			«fsa.generateFile(RezeptGenerator.getDbkFileName(project, "Rezept_"+parentIndex+'_'+rezeptIndex+".dbk"),
			createChapter(fsa,project,rezept, parentIndex+" "+rezeptIndex))»
			«ENDFOR»
		</part>
	'''

	def static createChapter(IFileSystemAccess fsa, RezeptbuchProjekt project, RezeptBlatt rezept, String rezeptIndex) '''
<?xml version="1.0" encoding="UTF-8"?>
<chapter version="5.0" xmlns="http://docbook.org/ns/docbook"
         xmlns:xlink="http://www.w3.org/1999/xlink"
         xmlns:xi="http://www.w3.org/2001/XInclude"
         xmlns:ns5="http://www.w3.org/2000/svg"
         xmlns:ns4="http://www.w3.org/1998/Math/MathML"
         xmlns:ns3="http://www.w3.org/1999/xhtml"
         xmlns:db="http://docbook.org/ns/docbook">
 
 <chapterinfo>
 	<pubdate>«rezept.letzteAenderung» </pubdate>
 </chapterinfo>
 
<title>«rezept.titel»</title>
«IF rezept.untertitel != null»
	<subtitle>«rezept.untertitel»</subtitle>
«ENDIF»

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
«IF zutat.menge instanceof BestimmteMenge» 
	«val menge = zutat.menge as BestimmteMenge»
		«Helper.stripQuotes(menge.betrag)»
		«menge.details»
		«IF menge.einheit != Masseinheit.KEINEAUSWAHL && menge.einheit != Masseinheit.STUECK»
			«menge.einheit»
		«ENDIF»
«ENDIF»
«zutat.name»
«IF zutat.menge instanceof UnbestimmteMenge»
	«val menge = zutat.menge as UnbestimmteMenge»	
	«IF menge.menge != UnbestimmteMengenangabe.KEINEAUSWAHL»          		
		«menge.menge»
	«ENDIF»
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
		«Helper.stripQuotes(produktRef.anzahl)» x
			«IF produktRef.produkt.verpackung != Verpackung.KEINEAUSWAHL»
				«produktRef.produkt.verpackung»
			«ENDIF»
			«produktRef.produkt.name» 
			«IF produktRef.produkt.menge instanceof BestimmteMenge»
				«val menge = produktRef.produkt.menge as BestimmteMenge»
				«Helper.stripQuotes(menge.betrag)» 
				«IF menge.einheit != Masseinheit.KEINEAUSWAHL»
					«menge.einheit»
				«ENDIF»
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
		«IF bild.internetPage != null »
			<ulink url="«bild.internetPage.url»">
		«ELSE»
			<ulink url="«Helper.getFileRef(bild)»">
	 	«ENDIF»
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
					<imagedata contentwidth="2in" fileref="«Helper.getFileRef(bild)»">
					</imagedata>
				</imageobject>
				<!-- alternative beschreibung auf rein textbasierten Systemen -->
				<textobject>
					<phrase>«bild.beschreibung»</phrase>
				</textobject>
			</inlinemediaobject>
		</ulink>
		<footnote>
			<para>
				<trademark class='copyright'/>
				<author>
					<personname>
						<othername>«bild.urheber»</othername>
					</personname>
				</author>
				geschützt durch: «bild.lizenz».
			</para>
		</footnote>
	«ENDFOR»
	</para>

  </formalpara>
«ENDIF»

</chapter>
	'''

}
