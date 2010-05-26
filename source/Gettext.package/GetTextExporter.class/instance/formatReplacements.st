private
formatReplacements
	| replacements |
	replacements := OrderedCollection new.
	replacements add: '\' -> '\\'.
	replacements add: String cr -> '\n'.
	replacements add: String tab -> '\t'.
	replacements add: '"' -> '\"'.
	^ replacements