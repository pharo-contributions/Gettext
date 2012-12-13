testing
nodeIsInterestingString: node
	^ node value isString and: [ node value isSymbol not and: [ node value notEmpty ] ]