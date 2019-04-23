Class {
	#name : #WAGettextSlimeTransformationRule,
	#superclass : #GRSlimeTransformationRule,
	#instVars : [
		'checkForMethodNameFragments'
	],
	#classVars : [
		'CanvasSelectorsOfInterest',
		'CanvasSelectorsToIgnore'
	],
	#category : 'Seaside-Gettext-Slime'
}

{ #category : #'as yet unclassified' }
WAGettextSlimeTransformationRule class >> initialize [
	"self initialize"

	self initializeCanvasSelectors
]

{ #category : #'as yet unclassified' }
WAGettextSlimeTransformationRule class >> initializeCanvasSelectors [
	| jsSelectors |
	CanvasSelectorsOfInterest := (WAHtmlCanvas selectors select: [ :each | each isKeyword ]) asSet.
	CanvasSelectorsOfInterest remove: #heading:level:.
	CanvasSelectorsToIgnore := Set new.
	#(#render: #class: #id: #style: #attributeAt:put: #level: #heading:level: #translate: #on: #for: #handleRequest: #lint: #rationale: #at: #at:put: #resourceUrl: #url: #updateRoot: #updateUrl: #seasideTranslated #seasideLazyTranslated)
		do: [ :each | CanvasSelectorsToIgnore add: each ].
	jsSelectors := ((JSObject withAllSubclasses gather: [ :each | each selectors ]) select: [ :each | each isKeyword ])
		asSet.
	jsSelectors do: [ :each | CanvasSelectorsToIgnore add: each ].
	#(#with: #title: #text: #alert: #confirm: #label: #header:)
		do: [ :each | 
			CanvasSelectorsOfInterest add: each.
			CanvasSelectorsToIgnore remove: each ifAbsent: [ nil ] ]
]

{ #category : #'as yet unclassified' }
WAGettextSlimeTransformationRule class >> isVisible [
	^ self name ~= #WAGettextSlimeTransformationRule
]

{ #category : #'as yet unclassified' }
WAGettextSlimeTransformationRule class >> selectorsOfInterest [
	^ CanvasSelectorsOfInterest
]

{ #category : #'as yet unclassified' }
WAGettextSlimeTransformationRule class >> selectorsToIgnore [
	^ CanvasSelectorsToIgnore
]

{ #category : #'as yet unclassified' }
WAGettextSlimeTransformationRule >> doesNotContainNameFragments: aNode [
	^ checkForMethodNameFragments
		ifTrue: [ self methodNameFragmentsToIgnore allSatisfy: [ :eachRegex | (aNode selector asString matchesRegex: eachRegex) not  ]]
		ifFalse: [ true ]
]

{ #category : #'as yet unclassified' }
WAGettextSlimeTransformationRule >> group [
	^ 'Gettext'
]

{ #category : #'as yet unclassified' }
WAGettextSlimeTransformationRule >> initialize [
	super initialize.
	checkForMethodNameFragments := true
]

{ #category : #'as yet unclassified' }
WAGettextSlimeTransformationRule >> methodNameFragmentsToIgnore [
	"if you use things like tableClass: or divId as messages for CSS or JS or whatever add some regexes here to check for them'"

	^ #('\w+Id\:?' '\w+Class\:?' '\w+Span\:?' '\w+Width\:?' '\w+Offset\:?' '\w+Fragment\:?' 'test\w+\:?' 'log\w+\:?' 'fuel\w+\:?' 'tropo\w+\:?' 'stripe\w+\:?' '\w+[cC][sS][sS]\w+' '\w+[jJ][sS]\w+' '\w+[Uu]rl\w+\:?')
]

{ #category : #'as yet unclassified' }
WAGettextSlimeTransformationRule >> selectorsOfInterest [
	^ self class selectorsOfInterest
]

{ #category : #'as yet unclassified' }
WAGettextSlimeTransformationRule >> selectorsToIgnore [
	^self class selectorsToIgnore 
]
