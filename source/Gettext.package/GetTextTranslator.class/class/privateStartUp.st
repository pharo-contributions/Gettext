class initialization
privateStartUp
	self setupLocaleDirs.
	self availableLanguageLocaleIDs do: [ :localeID |
		NaturalLanguageTranslator translators 
				at: localeID 
				put: (self newForLocaleID: localeID).
	]