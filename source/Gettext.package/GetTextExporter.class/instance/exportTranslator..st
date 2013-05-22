exporting
exportTranslator: translator 
	"Export translation files. the file extention is 'po', or 'pot' if translator is nil "
	"GetTextExporter new exportTranslator: NaturalLanguageTranslator current "
	
	self 
		exportTranslator: translator 
		for: self class defaultSelectors 