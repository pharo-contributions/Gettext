private
arraySearch: aSymbol fromArray: anArray addTo: aCollection 
	"Find literals ahead of aSymbol from arrays in the method."
	"BUG: it can handle just one occurrence"
	| index |
	(index := anArray identityIndexOf: aSymbol) > 1
		ifTrue: [aCollection add: (anArray at: index - 1) asString].
	(anArray
		select: [:each | each isMemberOf: Array])
		do: [:each | self
				arraySearch: aSymbol
				fromArray: each
				addTo: aCollection].
	^ aCollection