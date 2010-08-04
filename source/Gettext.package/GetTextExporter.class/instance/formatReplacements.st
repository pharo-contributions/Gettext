private
formatReplacements
	| replacements |
	replacements := OrderedCollection new.
	replacements add: '\' -> '\\'.
	replacements add: String cr -> '\r'.
	replacements add: String tab -> '\t'.
	replacements add: '"' -> '\"'.
	^ replacements