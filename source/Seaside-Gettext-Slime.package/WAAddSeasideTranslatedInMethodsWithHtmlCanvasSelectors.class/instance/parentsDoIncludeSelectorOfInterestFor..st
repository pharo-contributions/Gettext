as yet unclassified
parentsDoIncludeSelectorOfInterestFor: node
	node parents reverse
		do: [ :each | 
			each isPragma
				ifTrue: [ ^ false ].
			each isMessage
				ifTrue: [ 
					(self selectorsToIgnore includes: each selector)
						ifTrue: [ ^ false ]
						ifFalse: [ 
							(self selectorsOfInterest includes: each selector)
								ifTrue: [ ^ self doesNotContainNameFragments: each ] ] ] ].
	^ false