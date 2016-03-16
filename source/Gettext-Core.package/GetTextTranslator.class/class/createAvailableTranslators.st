actions
createAvailableTranslators
	"Load new instances of translators corresponding 
	to the currently available translation files"
	
	self setupLocaleDirs.
	self availableLanguageLocaleIDs do: [ :localeID |
		NaturalLanguageTranslator translators 
				at: localeID 
				put: (self newForLocaleID: localeID).
	]