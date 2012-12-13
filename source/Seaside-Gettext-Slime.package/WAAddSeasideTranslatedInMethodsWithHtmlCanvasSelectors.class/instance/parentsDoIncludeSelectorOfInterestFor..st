as yet unclassified
parentsDoIncludeSelectorOfInterestFor: node
	^ node parents
		anySatisfy: [ :each | 
			each isMessage
				and: [ (self selectorsToIgnore includes: each selector) not and: [ self selectorsOfInterest includes: each selector ] ] ]