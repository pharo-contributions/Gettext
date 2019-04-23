translation
translate: aString inDomain: aDomainName locale: aLocale

	^ (GetTextTranslator availableForLocaleID: aLocale) translate: aString inDomain: aDomainName 