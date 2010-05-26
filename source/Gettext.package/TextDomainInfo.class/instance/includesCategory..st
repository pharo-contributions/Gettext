accessing
includesCategory: categorySymbol
	(categories includes: categorySymbol) ifTrue: [^true].
	categoryPrefixes do: [:each |
		(self category: categorySymbol matches: each) ifTrue: [^true]
	].

	^false.