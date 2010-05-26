private
search: aSymbol messageNode: aParseNode addTo: aCollection 
	aParseNode nodesDo: [:node | 
		node isMessageNode ifTrue: [
			node selector key = aSymbol ifTrue: [
				aCollection add: node]]].
	^ aCollection