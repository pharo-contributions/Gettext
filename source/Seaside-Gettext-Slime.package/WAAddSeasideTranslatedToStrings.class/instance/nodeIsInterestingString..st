testing
nodeIsInterestingString: node
	^ node value isString
		and: [ node value isSymbol not and: [ node value size > 1 and: [ self stringDoesNotIncludeSpeciaCharacters: node value ] ] ]