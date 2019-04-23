*Gettext-Core
translatedInDomain: domainName locale: aLocale

	"answer the receiver translated to the default language"
	^ NaturalLanguageTranslator translate: self inDomain: domainName locale: aLocale
 