package com.github.funthomas424242.language.generator

import com.github.funthomas424242.language.rezept.BenutzerTag
import com.github.funthomas424242.language.rezept.DiaetTag
import com.github.funthomas424242.language.rezept.ProjektBeschreibung
import com.github.funthomas424242.language.rezept.RezeptBlatt
import com.github.funthomas424242.language.rezept.Rezeptliste
import com.github.funthomas424242.language.rezept.StoffTag
import org.eclipse.xtext.generator.IFileSystemAccess
import com.github.funthomas424242.language.rezept.Literaturquelle
import com.github.funthomas424242.language.rezept.Personenquelle

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class PartGenerator {
	

	def static createPart(IFileSystemAccess fsa,ProjektBeschreibung project, Rezeptliste liste , int parentIndex) '''
	
	<part>
	    <title>«liste.name»</title>
	    «FOR rezept : liste.rezepte»
	    	«val rezeptIndex = liste.rezepte.indexOf(rezept)»
				<xi:include href="Rezept«parentIndex+'_'+rezeptIndex».dbk" />
				«fsa.generateFile(RezeptGenerator.getDbkFileName(project, parentIndex+'_'+rezeptIndex+".dbk"),
				createChapter(fsa,project,rezept, parentIndex+" "+rezeptIndex))»
		«ENDFOR»
	</part>
	'''
	def static createChapter(IFileSystemAccess fsa,ProjektBeschreibung project, RezeptBlatt rezept , String rezeptIndex) '''
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
					«IF rezept.tags.indexOf(tag)>0»
				   			,
					«ENDIF»
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
		[for (zutat : Zutat | rezept.zutaten)]
			<listitem>
	          <para>
					[if (zutat.menge.oclIsKindOf(UnbestimmteMenge))]
						[let menge : UnbestimmteMenge = zutat.menge.oclAsType(UnbestimmteMenge)]
							[menge.menge /] 
						[/let]
					[/if]
				[zutat.name /] 
					[if (zutat.menge.oclIsKindOf(BestimmteMenge))]
						[let menge : BestimmteMenge = zutat.menge.oclAsType(BestimmteMenge)]
							[menge.betrag /] [menge.einheit /]
						[/let]
					[/if]
			  </para>
	        </listitem>
		[/for]
	    </itemizedlist></para>
	  </formalpara>
	
	  <formalpara>
	    <title>Arbeitsschritte</title>
	
	    <para><orderedlist>
		[for (schritt : Arbeitsschritt | rezept.schritte)]
			<listitem>
	          <para>
				[schritt.beschreibung/]
			  </para>
			  [if (not schritt.notiz.oclIsUndefined())]
			  <note>
				  <para>
					[schritt.notiz.text/]
				  </para>
			  </note>
			  [/if]
	        </listitem>
		[/for]
	    </orderedlist ></para>
	
		[if (not rezept.notizen->isEmpty())]
			<formalpara>
		      <title>Hinweise</title>
			  <para>
				[for (notiz : Notiz | rezept.notizen)]
					<note>
		          		<para>[notiz.text/]</para>
			        </note>
				[/for]
	 		  </para>
		    </formalpara>
		[/if]
	  </formalpara>
	
	  <formalpara>
	    <title>Einkaufsempfehlung</title>
	
		[if (rezept.produkte->isEmpty())]
			<para>
				Keine verfügbar.
			</para>
		[else]
		    <para><itemizedlist>
			[for (produktRef : ProduktRef | rezept.produkte)]
			
				<listitem>
		          <para>
					[produktRef.menge/] x 
					[let produkt : Produkt = produktRef.produkt]
						[produkt.verpackung/]  [produkt.name/]
						[if (produkt.menge.oclIsKindOf(BestimmteMenge))]
							[let menge : BestimmteMenge = produkt.menge.oclAsType(BestimmteMenge)]
								[menge.betrag /] [menge.einheit /]
							[/let]
						[/if]
					[/let]
				  </para>
		        </listitem>
			
			[/for]
		    </itemizedlist></para>
		[/if]
	  </formalpara>
	
	[if (not rezept.bilder->isEmpty())]
	  <formalpara>
	    <title>Bilder</title>
	
		<para>
		[for (bild : Bild | rezept.bilder)]
	 	<inlinemediaobject>		
				<alt>[bild.beschreibung/]</alt>	
		        <imageobject>
					<info>
						<legalnotice><para>[bild.lizenz/]</para></legalnotice>
						<author>
							<personname>
	  							<othername>[bild.urheber/]</othername>
							</personname>
						</author>
			  		</info>
					<imagedata contentwidth="2in"
							[if (bild.ablageOrt.oclIsKindOf(InternetPfad))]
								[let ablage : InternetPfad = bild.ablageOrt.oclAsType(InternetPfad)]
									fileref="[ablage.url/]">
								[/let]
							[else]
								[let ablage : LokalerPfad = bild.ablageOrt.oclAsType(LokalerPfad)]
									fileref="[ablage.fileName/]">
								[/let]
							[/if]
					</imagedata>
				</imageobject>
				<!-- alternative beschreibung auf rein textbasierten Systemen -->
				<textobject>
					<phrase>[bild.beschreibung/]</phrase>
				</textobject>
		</inlinemediaobject>
		<footnote><para>
			<trademark class='copyright'/>
			<author>
				<personname>
					<othername>[bild.urheber/]</othername>
				</personname>
			</author>
			geschützt durch:  [bild.lizenz/].
		</para></footnote>
		[/for]
		</para>
	
	  </formalpara>
	  [/if]
	
	</chapter>
	
	   
	[/file]
	[/template]
	
	'''
	
	
}
