testing
parentsDoNotSendMethodToIgnore: node

	node parents reverse
		do: [ :each | 
			(each isPragma or:[each isLiteralArray ])
				ifTrue: [ ^ false ].
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