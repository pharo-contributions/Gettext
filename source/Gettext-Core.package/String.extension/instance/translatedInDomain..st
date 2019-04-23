*Gettext-Core
translatedInDomain: domainName

"answer the receiver translated to the default language"
	^ NaturalLanguageTranslator translate: self inDomain: domainName
 