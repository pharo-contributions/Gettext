testing
nodeIsInterestingString: node
	^ node value isString
		and: [ 
			
			node value size > 1 and:[self stringDoesNotIncludeSpeciaCharacters:node value] ]