Class {
	#name : #WAAddSeasideTranslatedInMethodsWithHtmlCanvasSelectors,
	#superclass : #WAGettextSlimeTransformationRule,
	#category : 'Seaside-Gettext-Slime'
}

{ #category : #'as yet unclassified' }
WAAddSeasideTranslatedInMethodsWithHtmlCanvasSelectors >> initialize [
	super initialize.
	self rewriteRule
		replace: '`@object '
		with: '`@object seasideTranslated'
		when: [ :node | (self nodeIsInterestingString: node) and: [ self parentsDoIncludeSelectorOfInterestFor: node ] ]
]

{ #category : #'as yet unclassified' }
WAAddSeasideTranslatedInMethodsWithHtmlCanvasSelectors >> name [
	^ 'Add seasideTranslated to methods with WAHtmlCanvas selectors'
]

{ #category : #testing }
WAAddSeasideTranslatedInMethodsWithHtmlCanvasSelectors >> nodeIsInterestingString: node [
	^ node value isString and: [ node value isSymbol not and: [ node value notEmpty ] ]
]

{ #category : #'as yet unclassified' }
WAAddSeasideTranslatedInMethodsWithHtmlCanvasSelectors >> parentsDoIncludeSelectorOfInterestFor: node [
	node parents reverse
		do: [ :each | 
			each isPragma
				ifTrue: [ ^ false ].
			each isMessage
				ifTrue: [ 
					(self selectorsToIgnore includes: each selector)
						ifTrue: [ ^ false ]
						ifFalse: [ 
							(self selectorsOfInterest includes: each selector)
								ifTrue: [ ^ self doesNotContainNameFragments: each ] ] ] ].
	^ false
]

{ #category : #'as yet unclassified' }
WAAddSeasideTranslatedInMethodsWithHtmlCanvasSelectors >> rationale [
	^ 'strings that are concatenated should have each of their string literal parts translated. This is very slow.'
]
