accessing
nonLiteralReceiversOf: aSymbol
	"self new nonLiteralReceiversOf: aSymbol"
	| receivers |
	"Answer method references of non literal senders of #translated"
	^ (SystemNavigation default allCallsOn: aSymbol)
		select: [:message | 
			receivers := OrderedCollection new.
			self search: aSymbol messageNode: (message realClass parseTreeFor: message selector) addTo: receivers.
			receivers
				anySatisfy: [:each | (each receiver isLiteralNode) not]]