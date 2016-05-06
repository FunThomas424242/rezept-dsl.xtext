package com.github.funthomas424242.language.generator

import com.github.funthomas424242.language.rezept.ProjektBeschreibung
import com.github.funthomas424242.language.rezept.RezeptImport
import org.eclipse.emf.common.util.EList
import org.eclipse.xtext.generator.IFileSystemAccess
import com.github.funthomas424242.language.rezept.Rezeptliste

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class PartGenerator {
	

	def static createPart(IFileSystemAccess fsa,ProjektBeschreibung project, Rezeptliste liste , int parentIndex) '''
	
	«liste.name»
	<part>
	    <title>[liste.name/]</title>
		[for (rezept : Rezept | liste.rezepte)]
		    [let rezeptIndex : Integer = liste.rezepte->indexOf(rezept)]
				[if (rezept.oclIsKindOf(Rezept))]
					<xi:include href="Rezept[parentIndex+'_'+rezeptIndex.toString()/].dbk" />
					[createSection(project,rezept.oclAsType(Rezept), parentIndex+'_'+rezeptIndex.toString()) /]
				[/if]
			[/let]
		[/for]
	</part>
	'''
	def static createChapter(IFileSystemAccess fsa,ProjektBeschreibung project, EList<RezeptImport> liste , int parentIndex) '''
	
	[template public createSection(project: ProjektBeschreibung, rezept : Rezept, rezeptIndex : String )]
		[file (projectPath(project)+'/src/main/docbkx/Rezept'+rezeptIndex+'.dbk', false, 'UTF-8')]
	<?xml version="1.0" encoding="UTF-8"?>
	<chapter version="5.0" xmlns="http://docbook.org/ns/docbook"
	         xmlns:xlink="http://www.w3.org/1999/xlink"
	         xmlns:xi="http://www.w3.org/2001/XInclude"
	         xmlns:ns5="http://www.w3.org/2000/svg"
	         xmlns:ns4="http://www.w3.org/1998/Math/MathML"
	         xmlns:ns3="http://www.w3.org/1999/xhtml"
	         xmlns:db="http://docbook.org/ns/docbook">
	 
	<title>[rezept.titel/]</title>
	
	<para>
		<variablelist>
	      <varlistentry>
	        <term>Tags:</term>
			<listitem>
		    	<para>
				[for (tag : Tag | rezept.tags)]
					[if (rezept.tags->indexOf(tag) > 1)]
						,
					[/if]
					[if (tag.oclIsKindOf(BenutzerTag))]
						[let curTag : BenutzerTag = tag.oclAsType(BenutzerTag)]
							[curTag.bezeichnung /]
						[/let]
					[/if]
					[if (tag.oclIsKindOf(StoffTag))]
						[let curTag : StoffTag = tag.oclAsType(StoffTag)]
							[curTag.stoff /]
						[/let]
					[/if]
					[if (tag.oclIsKindOf(DiaetTag))]
						[let curTag : DiaetTag = tag.oclAsType(DiaetTag)]
							[curTag.diaet /]
						[/let]
					[/if]
				[/for]
				</para>
			</listitem>
	      </varlistentry>
		  <varlistentry>
		    <term>Quelle:</term>
			<listitem><para>
					[if (rezept.quelle->isEmpty())]
						nicht angegeben
					[else]
						[if (rezept.quelle.oclIsKindOf(Literaturquelle))]
							[let quelle : Literaturquelle = rezept.quelle.oclAsType(Literaturquelle)]
								[quelle.modifikationsArt/] übernommen aus: [quelle.beschreibung/]
							[/let]
						[/if]
						[if (rezept.quelle.oclIsKindOf(Personenquelle))]
							[let quelle : Personenquelle = rezept.quelle.oclAsType(Personenquelle)]
								überliefert von [quelle.personenBeschreibung/]
							[/let]
						[/if]
					[/if]
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
