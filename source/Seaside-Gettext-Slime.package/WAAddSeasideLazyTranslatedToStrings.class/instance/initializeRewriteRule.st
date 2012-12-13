as yet unclassified
initializeRewriteRule
	self rewriteRule
		replace: '`@object '
		with: '`@object seasideLazyTranslated'
		when: [ :node | self shouldNodeBeTransformed: node ]