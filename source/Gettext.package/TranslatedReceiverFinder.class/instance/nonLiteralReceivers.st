accessing
nonLiteralReceivers
	"self new nonLiteralReceivers"
	| receivers |
	"Answer method references of non literal senders of #translated"
	^ (SystemNavigation default allCallsOn: #translated)
		select: [:message | 
			receivers := OrderedCollection new.
			self search: #translated messageNode: message decompile addTo: receivers.
			receivers
				anySatisfy: [:each | (each receiver isMemberOf: LiteralNode) not]]