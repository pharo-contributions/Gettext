*Gettext-Core
translate: aString inDomain: domainName locale: locale

	^ Current 
		ifNotNil: [ Current translate: aString inDomain: domainName locale: locale ]
		ifNil: [ aString ].