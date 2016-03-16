utilities
exportTemplateFor: someSelectors
	"Writes files to be used as the translation template.
	It will include strings that are receivers of any of someSelectors"
	
	self new exportTranslator: nil for: someSelectors 