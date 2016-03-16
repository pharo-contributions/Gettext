accessing
allKnownDomains
	| domains |
	domains := Set new.
	domains addAll: ClassCategories values.
	domains add: self defaultDomain.
	^domains
