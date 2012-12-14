as yet unclassified
isLiteralStringArrayOfSize6OrLess: node
	^ node isLiteralArray
		and: [ 
			node contents notEmpty
				and: [ node contents size <= 6 and: [ node contents allSatisfy: [ :each | each isString and: [ each isSymbol not ] ] ] ] ]