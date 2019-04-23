"
emulation of gettext runtime
Known limitation:  
     currently don't support prural form.

"
Class {
	#name : #GetTextTranslator,
	#superclass : #NaturalLanguageTranslator,
	#instVars : [
		'moFiles',
		'id'
	],
	#classVars : [
		'LocaleDirsForDomain',
		'SystemDefaultLocaleDirs',
		'Translators',
		'UserDefaultLocaleDirs'
	],
	#category : 'Gettext-Core'
}

{ #category : #'translation data layout' }
GetTextTranslator class >> addSystemDefaultLocaleDir: dir [
	"new dir will be put as first"
 	self systemDefaultLocaleDirs addFirst: dir
]

{ #category : #accessing }
GetTextTranslator class >> availableForLocaleID: localeID [
	"Answer available locale ID.
	If translator is not found for correct locale ID, then isoLanguage is
	attempted for the key."

	^ self translators
		at: localeID
		ifAbsent: [ localeID hasParent
				ifTrue: [ self translators at: localeID parent ifAbsent: [ self default ] ]
				ifFalse: [ self default ] ]
]

{ #category : #accessing }
GetTextTranslator class >> availableLanguageLocaleIDs [
	"GetTextTranslator availableLanguageLocaleIDs"

	| ids dirs localeDirForLang directoryNames |
	ids := Set new.
	dirs := Set new.
	dirs addAll: LocaleDirsForDomain values.
	dirs addAll: self defaultLocaleDirs.
	dirs
		do: [ :dir | 
			| localesDir |
			localesDir := dir asFileReference ensureCreateDirectory.
			directoryNames := [ localesDir directoryNames ]
				on: DirectoryDoesNotExist
				do: [ :e | #() ].
			directoryNames
				do: [ :langDirName | 
					| localeID |
					localeID := LocaleID posixName: langDirName.
					localeDirForLang := (localesDir fullName , '/' , (self langDirNameForLocaleID: localeID)) asFileReference ensureCreateDirectory.
					localeDirForLang ifNotNil: [ (localeDirForLang filesMatching: '*.mo') ifNotEmpty: [ ids add: localeID ] ] ] ].
	^ ids
]

{ #category : #actions }
GetTextTranslator class >> createAvailableTranslators [
	"Load new instances of translators corresponding 
	to the currently available translation files"
	
	self setupLocaleDirs.
	self availableLanguageLocaleIDs do: [ :localeID |
		self translators 
				at: localeID 
				put: (self newForLocaleID: localeID).
	]
]

{ #category : #accessing }
GetTextTranslator class >> default [
	"Answer translator for backstop"
	"self default translate: 'test'"
	^ self new
		localeID: (LocaleID isoLanguage: 'en')
]

{ #category : #'translation data layout' }
GetTextTranslator class >> defaultLocaleDirs [
	| dirs |
	dirs := OrderedCollection new.
	UserDefaultLocaleDirs ifNotNil: [dirs addAll: UserDefaultLocaleDirs].
	dirs addAll: self systemDefaultLocaleDirs.
	^dirs

]

{ #category : #private }
GetTextTranslator class >> findMOForLocaleID: id domain: aDomainName [
	| sepa langSubDir path |
	sepa := FileSystem disk delimiter asString.
	langSubDir := self langDirNameForLocaleID: id.
	(self localeDirsForDomain: aDomainName)
		do: [:each |
			path := each , sepa , langSubDir, sepa , (self moNameForDomain: aDomainName).
			[(path asFileReference exists)
				 ifTrue: [^path]] on: DirectoryDoesNotExist do: [:e | ^nil]].
	^nil.
]

{ #category : #actions }
GetTextTranslator class >> hardReset [
	"Flush all remembered stuff.
	Load new translators (based on the files currently found)"	
	
	SystemDefaultLocaleDirs := OrderedCollection new.
	UserDefaultLocaleDirs := OrderedCollection new.
	LocaleDirsForDomain := Dictionary new.
	Translators := nil.

	self createAvailableTranslators 
	
]

{ #category : #'class initialization' }
GetTextTranslator class >> initialize [

	SystemDefaultLocaleDirs := OrderedCollection new.
	UserDefaultLocaleDirs := OrderedCollection new.
	LocaleDirsForDomain := Dictionary new.
]

{ #category : #private }
GetTextTranslator class >> langDirNameForLocaleID: id [
	"returns relative path from locale directory to actual directory containing MOs"
	^(id posixName) , (FileSystem disk delimiter asString)  , 'LC_MESSAGES'
]

{ #category : #'translation data layout' }
GetTextTranslator class >> localeDirForDomain: aDomainName [
	"returns registered localeDirectory for the textdomain. returns nil if not registered"
	^LocaleDirsForDomain at: aDomainName ifAbsent: [nil]
]

{ #category : #private }
GetTextTranslator class >> localeDirsForDomain [
	^LocaleDirsForDomain ifNil: [LocaleDirsForDomain := Dictionary new]
]

{ #category : #'translation data layout' }
GetTextTranslator class >> localeDirsForDomain: aDomainName [
	"returns collection of locale directories for text domain.  
	This includes user defined one for the domain, user defaults and system defaults" 
	| dirs dir |
	dirs := OrderedCollection new.
	dir := self localeDirForDomain: aDomainName.
	dir ifNotNil: [dirs add: dir].
	dirs addAll:  self defaultLocaleDirs. 
	
	^dirs
]

{ #category : #private }
GetTextTranslator class >> moNameForDomain: domainName [
	^domainName , '.mo'
]

{ #category : #'instance creation' }
GetTextTranslator class >> newForLocaleID: id [
	^self new localeID: id
]

{ #category : #private }
GetTextTranslator class >> privateStartUp [
	self reset
]

{ #category : #actions }
GetTextTranslator class >> reset [
	"Flush remembered stuff.
	Load new translators (based on the files currently found)"	
	self createAvailableTranslators 
	 
	
]

{ #category : #'translation data layout' }
GetTextTranslator class >> setLocaleDir: path forDomain: aDomainName [
	LocaleDirsForDomain
		at: aDomainName
		put: path.
]

{ #category : #'translation data layout' }
GetTextTranslator class >> setupLocaleDirs [
	| dirs sepa localesDirName |
	sepa := FileSystem disk delimiter asString.
	SystemDefaultLocaleDirs := nil.
	dirs := self systemDefaultLocaleDirs.
	localesDirName := 'locale'.
	dirs add: Smalltalk imageDirectory fullName , sepa , localesDirName.
	dirs add: Smalltalk vm directory , sepa , localesDirName.
	^ dirs
]

{ #category : #'class initialization' }
GetTextTranslator class >> startUp: resuming [ 
	resuming
		ifFalse: [^ self].
	self privateStartUp.
]

{ #category : #'translation data layout' }
GetTextTranslator class >> systemDefaultLocaleDirs [
	^SystemDefaultLocaleDirs ifNil: [SystemDefaultLocaleDirs := OrderedCollection new]

]

{ #category : #accessing }
GetTextTranslator class >> translators [
	^ Translators ifNil: [Translators := Dictionary new]	
]

{ #category : #'translation data layout' }
GetTextTranslator class >> userDefaultLocaleDirs [
	^UserDefaultLocaleDirs ifNil: [UserDefaultLocaleDirs := OrderedCollection new]

]

{ #category : #accessing }
GetTextTranslator >> atRandom [

	| v |
	moFiles ifEmpty: [^ ''].
	(v := moFiles atRandom value) ifNil: [^ ''].
	^ v atRandom.

]

{ #category : #accessing }
GetTextTranslator >> domainRegistered: aDomainName [
	"only current translator actually load the MO, to minimize loading time.
	 other translator will load anyway when it goes current"
	(self class current == self) 
		ifTrue: [self moFileForDomain: aDomainName].
	
]

{ #category : #accessing }
GetTextTranslator >> domainUnregistered: aDomainName [
	moFiles removeKey: aDomainName ifAbsent: [^self]
	
]

{ #category : #'initialize-release' }
GetTextTranslator >> initialize [
	moFiles := Dictionary new.
]

{ #category : #accessing }
GetTextTranslator >> isDomainLoaded: aDomainName [
	| mo |
	mo := moFiles at: aDomainName ifAbsent: [nil].
	^mo isNil not.

]

{ #category : #private }
GetTextTranslator >> loadMOFileForDomain: aDomainName [
	| moName |

	moName := self class findMOForLocaleID: self localeID 
								domain: aDomainName.
	moName notNil
			 ifTrue: [^MOFile new load: moName
								localeID: self localeID]
			ifFalse: [^nil]

]

{ #category : #accessing }
GetTextTranslator >> loadMOFiles [
	TextDomainManager allKnownDomains 
		do: [:domainName |
			self moFileForDomain: domainName
		].
]

{ #category : #accessing }
GetTextTranslator >> localeID [
	^id
]

{ #category : #accessing }
GetTextTranslator >> localeID: anID [
	id := anID
]

{ #category : #private }
GetTextTranslator >> moFileForDomain: domainName [
	"Returns the cached MOFile for the given domainName (or nil).
	If none is cached, it will try to load one (every time) and cache it on demand."
	| moFile |

	^moFiles 
		at: domainName 
		ifAbsent: [
			moFile := self loadMOFileForDomain: domainName.
			moFile notNil ifTrue:[
				moFiles at: domainName put: moFile].
			moFile]
]

{ #category : #accessing }
GetTextTranslator >> refresh [
	"Purge the cached translations (and load on demand)"
	
	moFiles := Dictionary new

]

{ #category : #accessing }
GetTextTranslator >> reloadMOFiles [
	
	self deprecated: 'Use the more intuitive refresh method'.
	
	self refresh
]

{ #category : #'language switching' }
GetTextTranslator >> setCurrent [
	"ensure actual contents of MOs is loaded on switching language"
	self loadMOFiles
]

{ #category : #translation }
GetTextTranslator >> translate: aString [

	^ self translate: aString inDomain: #pharo
]

{ #category : #translation }
GetTextTranslator >> translate: aString inDomain: aDomainName [

	| mo result |

	mo := self moFileForDomain: aDomainName.
	result := mo isNil 
		ifTrue: [ GetTextUnsucessfulTranslationResult original: aString] 
		ifFalse: [ mo translationFor: aString ].

	^ (result isSuccessful not and: [ self localeID isoCountry notNil ])
		ifTrue: [ self translateIgnoringCountry: aString inDomain: aDomainName ]
		ifFalse: [ result translation ]

]

{ #category : #translation }
GetTextTranslator >> translate: aString inDomain: aDomainName locale: aLocale [

	^ (GetTextTranslator availableForLocaleID: aLocale) translate: aString inDomain: aDomainName 
]

{ #category : #translation }
GetTextTranslator >> translateIgnoringCountry: aString inDomain: aDomainName [

	"try tranlation ignoring the country information in my locale"

	| languageLocale newTranslator |
	languageLocale := LocaleID isoLanguage: self localeID isoLanguage.
	newTranslator := GetTextTranslator availableForLocaleID: languageLocale.
	^ newTranslator translate: aString inDomain: aDomainName

]
