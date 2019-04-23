Class {
	#name : #WAAddSeasideTranslatedToStrings,
	#superclass : #WAGettextSlimeTransformationRule,
	#classVars : [
		'InterestingSubclasses',
		'MethodsToIgnore'
	],
	#category : 'Seaside-Gettext-Slime'
}

{ #category : #'as yet unclassified' }
WAAddSeasideTranslatedToStrings class >> initialize [
	"self initialize"

	self initializeCanvasSelectors.
	MethodsToIgnore := CanvasSelectorsOfInterest , CanvasSelectorsToIgnore.
	MethodsToIgnore remove: #nextPutAll:.
	InterestingSubclasses := WAPainter allSubclasses asSet
]

{ #category : #'as yet unclassified' }
WAAddSeasideTranslatedToStrings class >> methodsToIgnore [
	^ MethodsToIgnore
]

{ #category : #'as yet unclassified' }
WAAddSeasideTranslatedToStrings >> classIsWAPainterSubclass [
	^ (class name = #WAGettextMockComponent and: [ class name ~= #WAGettextMockObject ])
		or: [ InterestingSubclasses includes: class ]
]

{ #category : #'as yet unclassified' }
WAAddSeasideTranslatedToStrings >> initialize [
	super initialize.
	self initializeRewriteRule
]

{ #category : #'as yet unclassified' }
WAAddSeasideTranslatedToStrings >> initializeRewriteRule [
	self rewriteRule
		replace: '`@object '
		with: '`@object seasideTranslated'
		when: [ :node | self shouldNodeBeTransformed: node ]
]

{ #category : #'as yet unclassified' }
WAAddSeasideTranslatedToStrings >> methodsToIgnore [
	^ self class methodsToIgnore
]

{ #category : #'as yet unclassified' }
WAAddSeasideTranslatedToStrings >> name [
	^ 'Add seasideTranslated to every string'
]

{ #category : #testing }
WAAddSeasideTranslatedToStrings >> nodeIsInterestingString: node [
	^ node value isString
		and: [ node value isSymbol not and: [ node value size > 1 and: [ self stringDoesNotIncludeSpeciaCharacters: node value ] ] ]
]

{ #category : #testing }
WAAddSeasideTranslatedToStrings >> parentsDoNotSendMethodToIgnore: node [

	node parents reverse
		do: [ :each | 
			(each isPragma or:[each isLiteralArray ])
				ifTrue: [ ^ false ].
			each isMessage
				ifTrue: [ 
					(self methodsToIgnore includes: each selector)
						ifTrue: [ ^ false ]
						ifFalse: [ 
							(self doesNotContainNameFragments: each)
								ifFalse: [ ^ false ] ] ]
				ifFalse: [ 
					each isMethod
						ifTrue: [ 
							(self doesNotContainNameFragments: each)
								ifFalse: [ ^ false ] ] ] ].
	^ true
]

{ #category : #'as yet unclassified' }
WAAddSeasideTranslatedToStrings >> rationale [
	^ 'This one is probably bad news as it will hit CSS and JS strings. Strings that are concatenated will have each of their string literal parts dumped into a translation file.'
]

{ #category : #'as yet unclassified' }
WAAddSeasideTranslatedToStrings >> shouldNodeBeTransformed: node [
	^ self classIsWAPainterSubclass
		and: [ (self nodeIsInterestingString: node) and: [ self parentsDoNotSendMethodToIgnore: node ] ]
]

{ #category : #testing }
WAAddSeasideTranslatedToStrings >> stringDoesNotIncludeSpeciaCharacters: aString [
	#($@)
		do: [ :eachCharacter | 
			(aString includes: eachCharacter)
				ifTrue: [ ^ false ] ].
	^ true
]
