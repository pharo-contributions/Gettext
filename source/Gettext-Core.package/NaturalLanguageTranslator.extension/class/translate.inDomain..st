*Gettext-Core
translate: aString inDomain: domainName

	^ Current 
		ifNotNil: [ Current translate: aString inDomain: domainName ]
		ifNil: [ aString ].