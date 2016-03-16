actions
searchMethodNode: aMethodNode addTo: aCollection

	(aMethodNode block isMemberOf: BlockNode) ifTrue: [self searchBlockNode: aMethodNode block addTo: aCollection].
	(aMethodNode block isMemberOf: MessageNode) ifTrue: [self searchMessageNode: aMethodNode block addTo: aCollection].
	(aMethodNode block isMemberOf: ReturnNode) ifTrue: [self searchReturnNode: aMethodNode block addTo: aCollection].
