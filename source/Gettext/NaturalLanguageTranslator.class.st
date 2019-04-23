"
abstract class of natural language translator.
Class side manages and holds loaded instances of concrete classes.
"
Class {
	#name : #NaturalLanguageTranslator,
	#superclass : #Object,
	#instVars : [
		'id'
	],
	#classVars : [
		'Translators'
	],
	#category : 'Gettext'
}

{ #category : #accessing }
NaturalLanguageTranslator class >> availableForLocaleID: localeID [ 
	"Answer available locale ID.
	If translator is not found for correct locale ID, then isoLanguage is
	attempted for the key."
	^ self translators
		at: localeID
		ifAbsent: [localeID hasParent
				ifTrue: [self translators
						at: localeID parent
						ifAbsent: [self default]]
				ifFalse: [self default]] 
]

{ #category : #accessing }
NaturalLanguageTranslator class >> availableLanguageLocaleIDs [
	"Return the locale ids for the currently available languages.  
	Meaning those which either internally or externally have  
	translations available."
	"NaturalLanguageTranslator availableLanguageLocaleIDs"
	^ self translators values collect:[:each | each localeID]
]

{ #category : #cleanup }
NaturalLanguageTranslator class >> cleanUp [
	AllKnownPhrases := nil
]

{ #category : #accessing }
NaturalLanguageTranslator class >> current [
	^ self availableForLocaleID: LocaleID current
]

{ #category : #accessing }
NaturalLanguageTranslator class >> current: aTranslator [
	"Register a translator that should receiver the translation messages"
	
	Current := aTranslator
]

{ #category : #accessing }
NaturalLanguageTranslator class >> default [
	"Answer translator for backstop"
	"self default translate: 'test'"
	^ self new
		localeID: (LocaleID isoLanguage: 'en')
]

{ #category : #accessing }
NaturalLanguageTranslator class >> domainRegistered: aDomainName [
	"notify that new TextDomain is registered"
	self translators do: [:each | each domainRegistered: aDomainName]
]

{ #category : #accessing }
NaturalLanguageTranslator class >> domainUnregistered: aDomainName [
	"notify that new TextDomain is unregistered"
	self translators do: [:each | each domainUnregistered: aDomainName]
]

{ #category : #'class initialization' }
NaturalLanguageTranslator class >> initialize [
	(Smalltalk classNamed: #SessionManager)
		ifNotNil: [:sessionManagerClass|
			sessionManagerClass default
				registerSystemClassNamed: self name
				atPriority: 100]
		ifNil: [Smalltalk addToStartUpList: NaturalLanguageTranslator after: FileLocator].
	
	
]

{ #category : #accessing }
NaturalLanguageTranslator class >> localeChanged [
	"notify some project starts to use this locale.
	 this facility may use the event to load translation data dynamically" 
	self current setCurrent

]

{ #category : #'class initialization' }
NaturalLanguageTranslator class >> privateStartUp [
	self reset.
	GetTextTranslator reset.
	self localeChanged.
]

{ #category : #accessing }
NaturalLanguageTranslator class >> removeLocaleID: localeID [ 
	"self removeLocaleID: (LocaleID isoString: 'ja-kids')"
	^ self translators
		removeKey: localeID
		ifAbsent: []
]

{ #category : #actions }
NaturalLanguageTranslator class >> reset [
	"Flush the translator instances"
	
	Translators := nil
]

{ #category : #accessing }
NaturalLanguageTranslator class >> resetCaches [

	self deprecated: 'Use #reset'.
	
	Translators := nil.
]

{ #category : #'class initialization' }
NaturalLanguageTranslator class >> startUp: resuming [ 
	resuming
		ifFalse: [^ self].
	self privateStartUp.
]

{ #category : #translation }
NaturalLanguageTranslator class >> translate: aString [
	^ self translate: aString toLocale: LocaleID current
]

{ #category : #translation }
NaturalLanguageTranslator class >> translate: aString toLocale: localeID [
	| here domain |
	here := thisContext sender sender sender methodClass.
	domain := TextDomainManager domainForClass: here.
	^ self translate: aString toLocale: localeID inDomain: domain
]

{ #category : #translation }
NaturalLanguageTranslator class >> translate: aString toLocale: localeID inDomain: aDomainName [
	^ (self availableForLocaleID: localeID)
		translate: aString inDomain: aDomainName
]

{ #category : #accessing }
NaturalLanguageTranslator class >> translators [
	^ Translators ifNil: [Translators := Dictionary new]	
]

{ #category : #accessing }
NaturalLanguageTranslator >> atRandom [

	self subclassResponsibility.

]

{ #category : #accessing }
NaturalLanguageTranslator >> domainRegistered: aDomainName [
	"notify that new TextDomain is registered.  Concrete subclass can responds to this event if needed"
]

{ #category : #accessing }
NaturalLanguageTranslator >> domainUnregistered: aDomainName [
	"notify that new TextDomain is unregistered.  Concrete subclass can responds to this event if needed"
]

{ #category : #accessing }
NaturalLanguageTranslator >> isDomainLoaded: aDomainName [
	"ask if translation dictionary for the domain has been loaded and available now for use"
	self subclassResponsibility.
]

{ #category : #accessing }
NaturalLanguageTranslator >> localeID [
	^id
]

{ #category : #accessing }
NaturalLanguageTranslator >> localeID: anID [
	id := anID
]

{ #category : #printing }
NaturalLanguageTranslator >> printOn: aStream [
	aStream nextPutAll: self class name; nextPut: $(; print: self localeID; nextPut: $)
]

{ #category : #'language switching' }
NaturalLanguageTranslator >> setCurrent [
	"notify locale of the translator become current"

]

{ #category : #translation }
NaturalLanguageTranslator >> translate: aString inDomain: aDomainName [
	^ aString
]
