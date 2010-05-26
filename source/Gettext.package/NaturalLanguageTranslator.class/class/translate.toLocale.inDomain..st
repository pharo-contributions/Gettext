translation
translate: aString toLocale: localeID inDomain: aDomainName
	^ (self availableForLocaleID: localeID)
		translate: aString inDomain: aDomainName