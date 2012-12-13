as yet unclassified
parentsDoNotSendMethodToIgnore: node
	
	^ node parents
		allSatisfy: [ :each | each isMessage not or: [ each isMessage and: [ (self methodsToIgnore includes: each selector) not ] ] ]