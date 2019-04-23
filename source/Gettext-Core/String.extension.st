Extension { #name : #String }

{ #category : #'*Gettext-Core' }
String >> translatedInDomain: domainName [

"answer the receiver translated to the default language"
	^ NaturalLanguageTranslator translate: self inDomain: domainName
 
]

{ #category : #'*Gettext-Core' }
String >> translatedInDomain: domainName locale: aLocale [

	"answer the receiver translated to the default language"
	^ NaturalLanguageTranslator translate: self inDomain: domainName locale: aLocale
 
]
