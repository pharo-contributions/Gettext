actions
searchBlockNode: aBlockNode addTo: aCollection

	aBlockNode statements do: [:e |
		(e isMemberOf: MessageNode) ifTrue: [self searchMessageNode: e addTo: aCollection].
		(e isMemberOf: ReturnNode) ifTrue: [self searchReturnNode: e addTo: aCollection].
	].
