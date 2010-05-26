private
appendVocabulary: aVocabulary domains: domains
	| domainName literalsForDomain literals references |
	literals := aVocabulary allUntranslatedWordings.
	literals addAll: aVocabulary allUntranslatedDocumentations.
	domainName := self getTextDomainForClassCategory: aVocabulary class category.
	literalsForDomain := domains at: domainName ifAbsentPut: Dictionary new.
	literals do: [ :literal |
		references := literalsForDomain at: literal ifAbsentPut: [OrderedCollection new].
		references add: (MethodReference new setStandardClass: aVocabulary class methodSymbol: #initialize)
	].
	