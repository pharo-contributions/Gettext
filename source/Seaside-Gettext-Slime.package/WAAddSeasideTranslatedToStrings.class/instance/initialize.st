as yet unclassified
initialize
	super initialize.
	self rewriteRule
		replace: '`@object '
		with: '`@object seasideTranslated'
		when: [ :node | (self nodeIsInterestingString: node) and: [ self parentsDoNotSendMethodToIgnore: node ] ]