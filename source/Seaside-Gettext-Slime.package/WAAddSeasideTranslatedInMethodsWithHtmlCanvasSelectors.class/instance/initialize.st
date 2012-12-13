as yet unclassified
initialize
	super initialize.
	self rewriteRule
		replace: '`@object '
		with: '`@object seasideTranslated'
		when: [ :node | node value isString and: [ self parentsDoIncludeSelectorOfInterestFor: node ] ]