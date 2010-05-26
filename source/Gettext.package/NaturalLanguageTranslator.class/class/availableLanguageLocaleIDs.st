accessing
availableLanguageLocaleIDs
	"Return the locale ids for the currently available languages.  
	Meaning those which either internally or externally have  
	translations available."
	"NaturalLanguageTranslator availableLanguageLocaleIDs"
	^ self translators values collect:[:each | each localeID]