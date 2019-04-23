"
I am a utility class of Gettext. Most uses are internal to Gettext.

You can use me to browse all methods sending translation messages to non-string receivers:

	TranslatedReceiverFinder browseNonLiteralReceivers
"
Class {
	#name : #TranslatedReceiverFinder,
	#superclass : #Object,
	#category : 'Gettext-Core'
}

{ #category : #utilities }
TranslatedReceiverFinder class >> browseNonLiteralReceivers [
	"TranslatedReceiverFinder browseNonLiteralReceivers"
	SystemNavigation default
		browseMessageList: (self new nonLiteralReceiversOf: #translated)  asSortedCollection
		name: 'Non literal receivers of #translated'
		autoSelect: 'translated'
]

{ #category : #private }
TranslatedReceiverFinder >> arraySearch: aSymbol fromArray: anArray addTo: aCollection [ 
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
]

{ #category : #private }
TranslatedReceiverFinder >> arraySearch: aSymbol messageNode: aParseNode addTo: aCollection [ 
	"Find literals ahead of aSymbol from arrays in the method."
	
	aParseNode nodesDo: [:node |
		node isLiteral ifTrue: [
			(node literalValue isMemberOf: Array) ifTrue: [
				self 
					arraySearch: aSymbol
					fromArray: node literalValue
					addTo: aCollection]]].		
	^ aCollection
]

{ #category : #accessing }
TranslatedReceiverFinder >> findWordsWith: aSymbol in: aMethodReference [ 
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
]

{ #category : #accessing }
TranslatedReceiverFinder >> nonLiteralReceiversOf: aSymbol [
	"self new nonLiteralReceiversOf: aSymbol"
	| receivers |
	"Answer method references of non literal senders of #translated"
	^ (SystemNavigation default allCallsOn: aSymbol)
		select: [:message | 
			receivers := OrderedCollection new.
			self search: aSymbol messageNode: (message realClass parseTreeFor: message selector) addTo: receivers.
			receivers
				anySatisfy: [:each | (each receiver isLiteralNode) not]]
]

{ #category : #private }
TranslatedReceiverFinder >> search: aSymbol messageNode: aParseNode addTo: aCollection [ 
	aParseNode nodesDo: [:node | 
		node isMessage ifTrue: [
			node selector = aSymbol ifTrue: [
				aCollection add: node]]].
	^ aCollection
]

{ #category : #actions }
TranslatedReceiverFinder >> searchBlockNode: aBlockNode addTo: aCollection [

	aBlockNode statements do: [:e |
		(e isMemberOf: MessageNode) ifTrue: [self searchMessageNode: e addTo: aCollection].
		(e isMemberOf: ReturnNode) ifTrue: [self searchReturnNode: e addTo: aCollection].
	].

]

{ #category : #actions }
TranslatedReceiverFinder >> searchMessageNode: aMessageNode addTo: aCollection [

	((aMessageNode receiver isMemberOf: LiteralNode) and: [(aMessageNode selector isMemberOf: SelectorNode) and: [aMessageNode selector key = #translated]]) ifTrue: [
		aCollection add: aMessageNode receiver key.
	].

	(aMessageNode receiver isMemberOf: BlockNode) ifTrue: [self searchBlockNode: aMessageNode receiver addTo: aCollection].
	(aMessageNode receiver isMemberOf: MessageNode) ifTrue: [self searchMessageNode: aMessageNode receiver addTo: aCollection].
	(aMessageNode receiver isMemberOf: ReturnNode) ifTrue: [self searchReturnNode: aMessageNode receiver addTo: aCollection].

	aMessageNode arguments do: [:a |
		(a isMemberOf: BlockNode) ifTrue: [self searchBlockNode: a addTo: aCollection].
		(a isMemberOf: MessageNode) ifTrue: [self searchMessageNode: a addTo: aCollection].
		(a isMemberOf: ReturnNode) ifTrue: [self searchReturnNode: a addTo: aCollection].
	].

]

{ #category : #actions }
TranslatedReceiverFinder >> searchMethodNode: aMethodNode addTo: aCollection [

	(aMethodNode block isMemberOf: BlockNode) ifTrue: [self searchBlockNode: aMethodNode block addTo: aCollection].
	(aMethodNode block isMemberOf: MessageNode) ifTrue: [self searchMessageNode: aMethodNode block addTo: aCollection].
	(aMethodNode block isMemberOf: ReturnNode) ifTrue: [self searchReturnNode: aMethodNode block addTo: aCollection].

]

{ #category : #actions }
TranslatedReceiverFinder >> searchReturnNode: aReturnNode addTo: aCollection [

	(aReturnNode expr isMemberOf: BlockNode) ifTrue: [self searchBlockNode: aReturnNode expr addTo: aCollection].
	(aReturnNode expr isMemberOf: MessageNode) ifTrue: [self searchMessageNode: aReturnNode expr addTo: aCollection].

]

{ #category : #actions }
TranslatedReceiverFinder >> senders [
	| m o |
	m := SystemNavigation default allCallsOn: #translated.
	m := m
		collect: [ :e | 
			e classIsMeta
				ifTrue: [ (Smalltalk globals at: e classSymbol) class decompile: e methodSymbol ]
				ifFalse: [ (Smalltalk globals at: e classSymbol) decompile: e methodSymbol ] ].
	o := OrderedCollection new.
	m do: [ :e | self searchMethodNode: e addTo: o ].
	^ o sort
]

{ #category : #accessing }
TranslatedReceiverFinder >> stringReceiversOf: aSymbol [
	"Find string receivers for a symbol.
	Answer a collection of aMethodReference -> {keyword. keyword...}"
	"self new stringReceiversOf: #translated"
	| keywords methodReferences |
	methodReferences := SystemNavigation default allCallsOn: aSymbol.
	^ methodReferences inject: OrderedCollection new into: [:list :next |
		keywords := self findWordsWith: aSymbol in: next.
		keywords
			ifNotEmpty: [list add: next -> keywords].
		list]

]
