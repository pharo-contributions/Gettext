as yet unclassified
initialize
	super initialize.
	self rewriteRule
		replace: '`@object '
		withValueFrom: [ :node | self newArrayOfLiteralsSourceFor: node ]
		when: [ :node | self isLiteralStringArrayOfSize6OrLess: node ]