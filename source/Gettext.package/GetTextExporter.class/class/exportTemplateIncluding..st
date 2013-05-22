utilities
exportTemplateIncluding: aSelector
	"Writes files to be used as the translation template.
	It will include strings that are receivers of aSelector"
	
	self exportTemplateFor: self defaultSelectors, {aSelector} 