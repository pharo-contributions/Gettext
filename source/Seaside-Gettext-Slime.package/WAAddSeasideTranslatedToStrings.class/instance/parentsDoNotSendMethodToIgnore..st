testing
parentsDoNotSendMethodToIgnore: node
	node parents reverse
		do: [ :each | 
			each isMessage
				ifTrue: [ 
					(self methodsToIgnore includes: each selector)
						ifTrue: [ ^ false ]
						ifFalse: [ 
							(self doesNotContainNameFragments: each)
								ifFalse: [ ^ false ] ] ]
				ifFalse: [ 
					each isMethod
						ifTrue: [ 
							(self doesNotContainNameFragments: each)
								ifFalse: [ ^ false ] ] ] ].
	^ true