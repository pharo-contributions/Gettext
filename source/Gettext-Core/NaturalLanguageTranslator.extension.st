Extension { #name : #NaturalLanguageTranslator }

{ #category : #'*Gettext-Core' }
NaturalLanguageTranslator class >> translate: aString inDomain: domainName [

	^ Current 
		ifNotNil: [ Current translate: aString inDomain: domainName ]
		ifNil: [ aString ].
]

{ #category : #'*Gettext-Core' }
NaturalLanguageTranslator class >> translate: aString inDomain: domainName locale: locale [

	^ Current 
		ifNotNil: [ Current translate: aString inDomain: domainName locale: locale ]
		ifNil: [ aString ].
]
