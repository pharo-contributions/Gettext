Class {
	#name : #WAReformLiteralArraysIntoArraysWithWithWithWithEtc,
	#superclass : #WAGettextSlimeTransformationRule,
	#category : 'Seaside-Gettext-Slime'
}

{ #category : #'as yet unclassified' }
WAReformLiteralArraysIntoArraysWithWithWithWithEtc >> initialize [
	super initialize.
	self rewriteRule
		replace: '`@object '
		withValueFrom: [ :node | self newArrayOfLiteralsSourceFor: node ]
		when: [ :node | self isLiteralStringArrayOfSize6OrLess: node ]
]

{ #category : #'as yet unclassified' }
WAReformLiteralArraysIntoArraysWithWithWithWithEtc >> isLiteralStringArrayOfSize6OrLess: node [
	^ node isLiteralArray
		and: [ 
			node contents notEmpty
				and: [ node contents size <= 6 and: [ node contents allSatisfy: [ :each | each isString and: [ each isSymbol not ] ] ] ] ]
]

{ #category : #'as yet unclassified' }
WAReformLiteralArraysIntoArraysWithWithWithWithEtc >> name [
	^ 'Attempt to replace the literal arrays'
]

{ #category : #'as yet unclassified' }
WAReformLiteralArraysIntoArraysWithWithWithWithEtc >> newArrayOfLiteralsSourceFor: node [
	| string message |
	string := String
		streamContents: [ :s | 
			s nextPutAll: 'Array '.
			node contents do: [ :eachLiteralNode | s nextPutAll: 'with: ''' , eachLiteralNode value , ''' ' ] ].
	message := RBParser parseExpression: string.
	^ message
]

{ #category : #'as yet unclassified' }
WAReformLiteralArraysIntoArraysWithWithWithWithEtc >> rationale [
	^ 'We are adding #seasideTranslated to everything which really does not work out very well with the #("adsf" "asdf") way of making arrays.'
]
