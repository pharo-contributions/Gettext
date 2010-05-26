exporting
exportTranslator: translator 
	"Export translation files. the file extention is 'po', or 'pot' if translator is nil "
	"GetTextExporter new exportTranslator: NaturalLanguageTranslator current "
	| domains |
	domains := Dictionary new.
	self appendTranslations: domains.
	domains
		keysAndValuesDo: [:domainName :value |
			self
				export: value
				translator: translator
				domain: domainName]