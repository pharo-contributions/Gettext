testing
parentsDoNotSendMethodToIgnore: node
	node parents reverse
		do: [ :each | 
			each isMessage
				ifTrue: [ 
					(self methodsToIgnore includes: each selector)
						ifTrue: [ ^ false ] ] ].
	^ true