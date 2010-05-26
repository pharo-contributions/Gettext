accessing
stringReceiversWithContext: aSymbol
	"Find string receivers for a symbol.
	Answer a collection of aMethodReference -> {keyword. keyword...}"
	"self new stringReceiversWithContext: #translated"
	| keywords methodReferences |
	methodReferences := SystemNavigation default allCallsOn: aSymbol.
	^ methodReferences inject: OrderedCollection new into: [:list :next |
		keywords := self findWordsWith: aSymbol in: next.
		keywords
			ifNotEmpty: [list add: next -> keywords].
		list]
