actions
searchMessageNode: aMessageNode addTo: aCollection

	((aMessageNode receiver isMemberOf: LiteralNode) and: [(aMessageNode selector isMemberOf: SelectorNode) and: [aMessageNode selector key = #translated]]) ifTrue: [
		aCollection add: aMessageNode receiver key.
	].

	(aMessageNode receiver isMemberOf: BlockNode) ifTrue: [self searchBlockNode: aMessageNode receiver addTo: aCollection].
	(aMessageNode receiver isMemberOf: MessageNode) ifTrue: [self searchMessageNode: aMessageNode receiver addTo: aCollection].
	(aMessageNode receiver isMemberOf: ReturnNode) ifTrue: [self searchReturnNode: aMessageNode receiver addTo: aCollection].

	aMessageNode arguments do: [:a |
		(a isMemberOf: BlockNode) ifTrue: [self searchBlockNode: a addTo: aCollection].
		(a isMemberOf: MessageNode) ifTrue: [self searchMessageNode: a addTo: aCollection].
		(a isMemberOf: ReturnNode) ifTrue: [self searchReturnNode: a addTo: aCollection].
	].
