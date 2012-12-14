as yet unclassified
newArrayOfLiteralsSourceFor: node
	| string message |
	string := String
		streamContents: [ :s | 
			s nextPutAll: 'Array '.
			node contents do: [ :eachLiteralNode | s nextPutAll: 'with: ''' , eachLiteralNode value , ''' ' ] ].
	message := RBParser parseExpression: string.
	^ message