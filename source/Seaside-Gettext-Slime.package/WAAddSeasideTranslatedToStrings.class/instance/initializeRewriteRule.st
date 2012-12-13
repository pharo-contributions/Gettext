as yet unclassified
initializeRewriteRule
	self rewriteRule
		replace: '`@object '
		with: '`@object seasideTranslated'
		when: [ :node | self shouldNodeBeTransformed: node ]