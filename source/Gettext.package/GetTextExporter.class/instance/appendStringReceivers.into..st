private
appendStringReceivers: aSymbol into: domains
	| literals references domainName methodReference keywords found |
	
	found := TranslatedReceiverFinder new stringReceiversOf: aSymbol.
	found do: [ :assoc |
		methodReference := assoc key.
		keywords := assoc value.
		domainName := self getTextDomainForClassCategory:
			(Smalltalk at: methodReference theNonMetaClassName) category.
		literals := domains at: domainName ifAbsentPut: [Dictionary new].
		keywords do: [ :literal |
			references := literals at: literal ifAbsentPut: [OrderedCollection new].
			references add: methodReference.
		].
	]. 
