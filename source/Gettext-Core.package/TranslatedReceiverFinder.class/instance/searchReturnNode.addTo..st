actions
searchReturnNode: aReturnNode addTo: aCollection

	(aReturnNode expr isMemberOf: BlockNode) ifTrue: [self searchBlockNode: aReturnNode expr addTo: aCollection].
	(aReturnNode expr isMemberOf: MessageNode) ifTrue: [self searchMessageNode: aReturnNode expr addTo: aCollection].
