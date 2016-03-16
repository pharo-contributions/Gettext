exporting
appendTranslations: domains for: someSelectors
	"Append translations in the given domains.
	Will be done by searching for strings receiving the given selectors"

	someSelectors do:[ :selector |
		self appendStringReceivers: selector into: domains]
