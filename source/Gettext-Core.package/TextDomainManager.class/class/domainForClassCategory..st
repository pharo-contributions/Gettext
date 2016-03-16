accessing
domainForClassCategory: aCategorySymbol
	^ClassCategories at: aCategorySymbol ifAbsent: [self defaultDomain]