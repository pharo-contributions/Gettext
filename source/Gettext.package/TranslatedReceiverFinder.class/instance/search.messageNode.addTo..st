private
search: aSymbol messageNode: aParseNode addTo: aCollection 
	aParseNode nodesDo: [:node | 
		node isMessage ifTrue: [
			node selector = aSymbol ifTrue: [
				aCollection add: node]]].
	^ aCollection