private
arraySearch: aSymbol messageNode: aParseNode addTo: aCollection 
	"Find literals ahead of aSymbol from arrays in the method."
	
	aParseNode nodesDo: [:node |
		node isLiteral ifTrue: [
			(node literalValue isMemberOf: Array) ifTrue: [
				self 
					arraySearch: aSymbol
					fromArray: node literalValue
					addTo: aCollection]]].		
	^ aCollection