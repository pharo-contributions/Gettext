as yet unclassified
initialize
	super initialize.
	self rewriteRule
		replace: '`@object '
		with: '`@object seasideTranslated'
		when: [ :node | 
			node value isString
				and: [ 
					node parents
						anySatisfy: [ :each | 
							each isMessage
								and: [ (self selectorsToIgnore includes: each selector) not and: [ self selectorsOfInterest includes: each selector ] ] ] ] ]