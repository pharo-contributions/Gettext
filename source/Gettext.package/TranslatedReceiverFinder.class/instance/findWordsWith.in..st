accessing
findWordsWith: aSymbol in: aMethodReference 
	"Find words for translation with the symbol in a method. See
	LanguageEditorTest >>testFindTranslatedWords"
	"| message | 
	message := MethodReference new setStandardClass: Morph class
	methodSymbol: #supplementaryPartsDescriptions.
	self new findWordsWIth: #translatedNoop in: message"
	| messages keywords aParseNode |

	aParseNode := aMethodReference methodClass parseTreeFor: aMethodReference selector.
	"Find from string literal"
	messages := Set new.
	self
		search: aSymbol
		messageNode: aParseNode
		addTo: messages.
	keywords := OrderedCollection new.
	messages
		select: [:aMessageNode | aMessageNode receiver isLiteralNode]
		thenDo: [:aMessageNode | keywords add: aMessageNode receiver value
				"literalStringsDo: [:literal | keywords add: literal]"].
	"Find from array literal"
	self
		arraySearch: aSymbol
		messageNode: aParseNode
		addTo: keywords.
	^ keywords