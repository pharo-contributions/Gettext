as yet unclassified
initialize
	super initialize.
	self rewriteRule
		replace: '`@object render: ``@args'
		with: '`@object translate: ``@args'
		when: [ :node | 
			node arguments
				allSatisfy: [ :each | each isLiteralNode and: [ each token value isString and: [ each token value isSymbol not ] ] ] ]