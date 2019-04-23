"
Export translations to gettext format divided into categories.

""Export gettext template files""
GetTextExporter new exportTemplate.

""Export translation files for current locale""
GetTextExporter new exportTranslator: (InternalTranslator newLocaleID: LocaleID current).

""Export all gettext template and po files.""
GetTextExporter exportAll.

""To register a class category as a new domain""
TextDomainManager registerClassCategory: 'Morphic-Books' domain: 'Book'.
""Remove a class category""
TextDomainManager unregisterClassCategory: 'Morphic-Books'.
"
Class {
	#name : #GetTextExporter,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : 'Gettext-Core'
}

{ #category : #accessing }
GetTextExporter class >> defaultSelectors [
	"Answers the selectors that are sent to strings that should be translated"
	
	^ #(
		#translated 
		#translatedInDomain:
		#translatedInDomain:locale:
		#translatedNoop
		)
]

{ #category : #utilities }
GetTextExporter class >> exportTemplate [
	"GetTextExporter exportTemplate"
	self new exportTemplate
]

{ #category : #utilities }
GetTextExporter class >> exportTemplateFor: someSelectors [
	"Writes files to be used as the translation template.
	It will include strings that are receivers of any of someSelectors"
	
	self new exportTranslator: nil for: someSelectors 
]

{ #category : #utilities }
GetTextExporter class >> exportTemplateIncluding: aSelector [
	"Writes files to be used as the translation template.
	It will include strings that are receivers of aSelector"
	
	self exportTemplateFor: self defaultSelectors, {aSelector} 
]

{ #category : #utilities }
GetTextExporter class >> keys [
	| categories |
	categories := Dictionary new.
	GetTextExporter new appendTranslations: categories.
	^ categories values
		inject: Set new
		into: [:set :next | set addAll: next keys;
				 yourself]
]

{ #category : #utilities }
GetTextExporter class >> listAllHelp [
	"self listAllHelp"
	| spec specs oCatalog flap flapSelectors allKeys oCatalogHelp flapHelp |
	oCatalog := Dictionary new.
	Morph withAllSubclasses
		do: [:aClass | (aClass class includesSelector: #descriptionForPartsBin)
				ifTrue: [spec := aClass descriptionForPartsBin.
					oCatalog at: spec formalName put: spec documentation]].
	Morph withAllSubclasses
		do: [:aClass | (aClass class includesSelector: #supplementaryPartsDescriptions)
				ifTrue: [specs := aClass supplementaryPartsDescriptions.
					specs
						do: [:each | oCatalog at: each formalName put: each documentation]]].
	flap := Dictionary new.
	flapSelectors := #(#defaultsQuadsDefiningPlugInSuppliesFlap #defaultsQuadsDefiningStackToolsFlap #defaultsQuadsDefiningSuppliesFlap #defaultsQuadsDefiningToolsFlap #defaultsQuadsDefiningWidgetsFlap #defaultsQuadsDefiningScriptingFlap ).
	flapSelectors
		do: [:selector | 
			specs := Flaps perform: selector.
			specs
				do: [:each | flap at: each third put: each fourth]].
	allKeys := oCatalog keys intersection: flap keys.
	allKeys asArray sort
		do: [:each | 
			oCatalogHelp := oCatalog
						at: each
						ifAbsent: [''].
			flapHelp := flap
						at: each
						ifAbsent: [''].
			oCatalogHelp = flapHelp
				ifFalse: [Transcript cr; show: 'Name: ' , each.
					Transcript cr; show: 'O: ' , oCatalogHelp.
					Transcript cr; show: 'F: ' , flapHelp.
					Transcript cr.

]]
]

{ #category : #private }
GetTextExporter >> appendStringReceivers: aSymbol into: domains [
	| literals references domainName methodReference keywords found |
	
	found := TranslatedReceiverFinder new stringReceiversOf: aSymbol.
	found do: [ :assoc |
		methodReference := assoc key.
		keywords := assoc value.
		domainName := self getTextDomainForClassCategory:
			(Smalltalk at: methodReference theNonMetaClassName) category.
		literals := domains at: domainName ifAbsentPut: [Dictionary new].
		keywords do: [ :literal |
			references := literals at: literal ifAbsentPut: [OrderedCollection new].
			references add: methodReference.
		].
	]. 

]

{ #category : #exporting }
GetTextExporter >> appendTranslations: domains [ 

	self 
		appendTranslations: domains 
		for: self class defaultSelectors 
]

{ #category : #exporting }
GetTextExporter >> appendTranslations: domains for: someSelectors [
	"Append translations in the given domains.
	Will be done by searching for strings receiving the given selectors"

	someSelectors do:[ :selector |
		self appendStringReceivers: selector into: domains]

]

{ #category : #private }
GetTextExporter >> appendVocabulary: aVocabulary domains: domains [
	| domainName literalsForDomain literals references |
	literals := aVocabulary allUntranslatedWordings.
	literals addAll: aVocabulary allUntranslatedDocumentations.
	domainName := self getTextDomainForClassCategory: aVocabulary class category.
	literalsForDomain := domains at: domainName ifAbsentPut: Dictionary new.
	literals do: [ :literal |
		references := literalsForDomain at: literal ifAbsentPut: [OrderedCollection new].
		references add: (MethodReference new setStandardClass: aVocabulary class methodSymbol: #initialize)
	].
	
]

{ #category : #private }
GetTextExporter >> createHeaders [
	| headers |
	headers := OrderedCollection new.
	headers add: 'Project-Id-Version' -> 'Pharo'.
	headers add: 'POT-Creation-Date' -> self currentDateAndTime.
	headers add: 'PO-Revision-Date' -> self currentDateAndTime.
	headers add: 'Last-Translator' -> ''.
	headers add: 'Language-Team' -> ''.
	headers add: 'MIME-Version' -> '1.0'.
	headers add: 'Content-Type' -> ('text/plain; charset=', stream converter class encodingNames first).
	headers add: 'Content-Transfer-Encoding' -> '8bit'.
	headers add: 'X-Pharo-SystemVersion' -> (SystemVersion current asString).
	^ headers
]

{ #category : #private }
GetTextExporter >> currentDateAndTime [
	^ String
		streamContents: [:aStream | 
			aStream nextPutAll: Date today yyyymmdd;
				space.
			Time now
				print24: true
				showSeconds: false
				on: aStream.
			aStream nextPutAll: '-0000']
]

{ #category : #exporting }
GetTextExporter >> dirNameCategory: category translator: translator [ 
	"Answer a file name for the category. Make one if it is not exist yet.
	Make template file name if translator is nil"
	"self new dirNameCategory: 'Morphic-Scripting Support' translator:
	NaturalLanguageTranslator current"
	"self new dirNameCategory: 'Morphic-Scripting Support' translator: nil"
	| safeCategory fileName dirName pathName |
	safeCategory := category copyReplaceAll: ' ' with: ':='.
	fileName := translator
				ifNil: [safeCategory , '.pot']
				ifNotNil: [translator localeID posixName , '.po'].
	dirName := (safeCategory findTokens: '-')
				inject: 'po'
				into: [:aString :next | aString , FileSystem disk delimiter asString , next].
	pathName := dirName , FileSystem disk delimiter asString , fileName.
	(dirName asFileReference ensureCreateDirectory).
	^ pathName
]

{ #category : #exporting }
GetTextExporter >> dirNameDomain: domain translator: translator [ 
	"Answer a file name for the domain. Make one if it is not exist yet.
	Make template file name if translator is nil"
	"self new dirNameDomain: 'etoys' translator:
	NaturalLanguageTranslator current"
	"self new dirNameDomain: 'etoys' translator: nil"
	| fileName dirName pathName |
	"safeCategory := category copyReplaceAll: ' ' with: ':='."
	fileName := translator
				ifNil: [domain , '.pot']
				ifNotNil: [translator localeID posixName , '.po'].
	dirName := 'po', FileSystem disk delimiter asString , domain.
	pathName := dirName ,  FileSystem disk delimiter asString , fileName.
	(dirName asFileReference ensureCreateDirectory).
	^ pathName
]

{ #category : #private }
GetTextExporter >> export: literals translator: translator domain: domainName [ 
	| fileName |
	"Export a gettext file in a category. literals is a dictionary of keyword -> #(MethodReference...) in the textDomain."
	fileName := self dirNameDomain: domainName translator: translator.
	[stream := FileStream forceNewFileNamed: fileName.
	stream lineEndConvention: #lf.
	stream converter: UTF8TextConverter new.
	self exportHeader: domainName.
	self exportBody: literals translator: translator]
		ensure: [stream close]
]

{ #category : #'file out' }
GetTextExporter >> exportBody: literals translator: translator [ 
	"Export a gettext file body. literals is a dictionary of keyword ->
	#(MethodReference...) in the textDomain."
	"Build {sortKey. comment. msgid } to optimize sorting (getting category is
	too slow).
	If there are two or more methods for a mgsid, only first method
	(alphabetical) is used for sorting."
	| sorted msgid sortedMethods category sortKey comment triplets commentUnderLined |
	triplets := literals associations
				collect: [:assoc | 
					msgid := assoc key.
					sortedMethods := assoc value asArray sort.
					category := (Smalltalk at: sortedMethods first theNonMetaClassName) category asString.
					sortKey := category , ',' , sortedMethods first printString , ',' , msgid.
					comment := (sortedMethods
								collect: [:each | each actualClass asString , '>>' , each selector asString])
								inject: category
								into: [:result :methodName | result , ',' , methodName].
					"Replace white spaces to := because gettext tool might
					replace a space to a new line some times, and it makes
					difficult to take a diff."
					commentUnderLined := comment copyReplaceAll: ' ' with: ':='.
					Array
						with: sortKey
						with: commentUnderLined
						with: msgid].
	"Sort and output the words"
	sorted := triplets
				sort: [:a :b | a first <= b first].
	sorted
		do: [:triplet | 
			comment := triplet second.
			msgid := triplet third.
			self exportRecordHeader: comment.
			self
				exportPhrase: msgid
				translation: (self translationFor: msgid in: translator)]
]

{ #category : #private }
GetTextExporter >> exportHeader: domainName [
	| headers |
	self exportTag: 'msgid' msg: ''.
	self exportTag: 'msgstr' msg: ''.
	headers := self createHeaders.
	headers add: 'X-Pharo-Domain' -> domainName.
	headers do: [:each | self exportHeaderLineKey: each key value: each value].
	stream cr; cr
]

{ #category : #private }
GetTextExporter >> exportHeaderLineKey: keyString value: valueString [ 
	stream nextPut: $";
		 nextPutAll: keyString;
		 nextPut: $:;
		 space;
		 nextPutAll: valueString;
		 nextPutAll: '\n';
		 nextPut: $";
		 cr.
]

{ #category : #private }
GetTextExporter >> exportPhrase: phraseString translation: translationString [ 
	| normalizedTrans tmp transStartsWithCR transEndsWithCR|
	phraseString isEmpty
		ifTrue: [^ self].
	self exportTag: 'msgid' msg: phraseString.
	translationString size = 0 ifTrue: [
		normalizedTrans := ''
	] ifFalse: [
		transEndsWithCR := translationString last = (Character cr).
		phraseString last = (Character cr) ifTrue: [
			transEndsWithCR ifTrue: [
				normalizedTrans := translationString
			] ifFalse: [
				normalizedTrans :=  translationString , String cr
			]
		] ifFalse: [
			transEndsWithCR ifTrue: [
				normalizedTrans := translationString allButLast
			] ifFalse: [
				normalizedTrans := translationString
			]
		].
		transStartsWithCR := normalizedTrans first = (Character cr).
		phraseString first = (Character cr) ifTrue: [
			transStartsWithCR ifFalse: [
				tmp := (Character cr asString) , normalizedTrans.
				normalizedTrans := tmp.
			]
		] ifFalse: [
			transStartsWithCR ifTrue: [
				normalizedTrans := normalizedTrans allButFirst
			]
		]
	].
	self exportTag: 'msgstr' msg: normalizedTrans.
	stream cr
]

{ #category : #private }
GetTextExporter >> exportRecordHeader: context [
	stream 
		nextPutAll: '#: ';
		nextPutAll: context;
		cr.
]

{ #category : #private }
GetTextExporter >> exportTag: tag msg: aString [ 
	| pos end line |
	(aString indexOf: Character cr)
			= 0
		ifTrue: [self exportTag: tag singleLine: aString]
		ifFalse: [self exportTag: tag singleLine: ''.
			pos := 1.
			end := 0.
			[end < aString size]
				whileTrue: [end := aString indexOf: Character cr startingAt: pos.
					end = 0
						ifTrue: [end := aString size].
					line := aString copyFrom: pos to: end.
					stream nextPut: $";
						
						nextPutAll: (self formatString: line);
						 nextPut: $";
						 cr.
					pos := end + 1]]
]

{ #category : #private }
GetTextExporter >> exportTag: tag singleLine: aString [ 
	stream nextPutAll: tag.
	stream space.
	stream nextPut: $".
	stream
		nextPutAll: (self formatString: aString).
	stream nextPut: $".
	stream cr
]

{ #category : #exporting }
GetTextExporter >> exportTemplate [
	"GetTextExporter new exportTemplate"
	self exportTranslator: nil
]

{ #category : #exporting }
GetTextExporter >> exportTranslator: translator [ 
	"Export translation files. the file extention is 'po', or 'pot' if translator is nil "
	"GetTextExporter new exportTranslator: NaturalLanguageTranslator current "
	
	self 
		exportTranslator: translator 
		for: self class defaultSelectors 
]

{ #category : #exporting }
GetTextExporter >> exportTranslator: translator for: someSelectors [
	"Export translation files. the file extention is 'po', or 'pot' if translator is nil "
	"GetTextExporter new exportTranslator: NaturalLanguageTranslator current "
	| domains |
	domains := Dictionary new.
	self appendTranslations: domains for: someSelectors.
	domains
		keysAndValuesDo: [:domainName :value |
			self
				export: value
				translator: translator
				domain: domainName]
]

{ #category : #private }
GetTextExporter >> formatReplacements [
	| replacements |
	replacements := OrderedCollection new.
	replacements add: '\' -> '\\'.
	replacements add: String cr -> '\r'.
	replacements add: String tab -> '\t'.
	replacements add: '"' -> '\"'.
	^ replacements
]

{ #category : #private }
GetTextExporter >> formatString: aString [ 
	| result |
	result := aString.
	self formatReplacements
		do: [:each | result := result copyReplaceAll: each key with: each value].
	^ result
]

{ #category : #private }
GetTextExporter >> getTextDomainForClassCategory: aClassCategory [
	^TextDomainManager domainForClassCategory:  aClassCategory
		
]

{ #category : #accessing }
GetTextExporter >> stream [
	^ stream
]

{ #category : #accessing }
GetTextExporter >> stream: aStream [
	stream := aStream
]

{ #category : #private }
GetTextExporter >> translationFor: aKey in: translator [
	translator ifNil: [^''].
	translator translations at: aKey ifPresent: [:s | ^s].
	"If we have old camelCase translations, make space-separated words"
	translator translations at: aKey toCamelCase ifPresent: [:s | 
		(s includes: Character space) ifTrue: [^s].
		^s fromCamelCase].
	^''
]
