translation
translate: aString toLocale: localeID
	| here domain |
	here := thisContext sender sender sender methodClass.
	domain := TextDomainManager domainForClass: here.
	^ self translate: aString toLocale: localeID inDomain: domain