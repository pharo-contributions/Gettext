Class {
	#name : #WAReplaceLiteralStringRenderMethodsWithTranslate,
	#superclass : #WAGettextSlimeTransformationRule,
	#category : 'Seaside-Gettext-Slime'
}

{ #category : #'as yet unclassified' }
WAReplaceLiteralStringRenderMethodsWithTranslate >> initialize [
	super initialize.
	self rewriteRule
		replace: '`@object render: ``@args'
		with: '`@object translate: ``@args'
		when: [ :node | 
			node arguments
				allSatisfy: [ :each | each isLiteralNode and: [ each token value isString and: [ each token value isSymbol not ] ] ] ]
]

{ #category : #'as yet unclassified' }
WAReplaceLiteralStringRenderMethodsWithTranslate >> name [
	^ 'Replace #render: with #translate: '
]

{ #category : #'as yet unclassified' }
WAReplaceLiteralStringRenderMethodsWithTranslate >> rationale [
	^ 'Replace #render:  with #translated: when the only argument is a string.'
]
