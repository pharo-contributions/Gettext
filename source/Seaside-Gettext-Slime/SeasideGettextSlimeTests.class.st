Class {
	#name : #SeasideGettextSlimeTests,
	#superclass : #TestCase,
	#instVars : [
		'environment',
		'model'
	],
	#category : 'Seaside-Gettext-Slime-Tests'
}

{ #category : #'as yet unclassified' }
SeasideGettextSlimeTests >> category [
	^ self class category , '-Data'
]

{ #category : #'as yet unclassified' }
SeasideGettextSlimeTests >> compile: aString in: aClass [
	^ aClass compile: aString classified: #(#rendering)
]

{ #category : #'as yet unclassified' }
SeasideGettextSlimeTests >> defineClass: aClassSymbol superclass: aSuperSymbol [
	| class |
	model
		defineClass:
			aSuperSymbol , ' subclass: #' , aClassSymbol
				,
					'
		instanceVariableNames: '''' 
		classVariableNames: ''''
		poolDictionaries: ''''
		category: ''' , self category , ''''.
	class := model classNamed: aClassSymbol.
	environment
		addClass: class;
		addClass: class theMetaClass.
	^ class
]

{ #category : #'as yet unclassified' }
SeasideGettextSlimeTests >> mockComponent [
	^ self defineClass: #WAGettextMockComponent superclass: #WAComponent
]

{ #category : #'as yet unclassified' }
SeasideGettextSlimeTests >> mockObject [
	^ self defineClass: #WAGettextMockObject superclass: #Object
]

{ #category : #'as yet unclassified' }
SeasideGettextSlimeTests >> run: aClass do: aBlock [
	| rules rule composite undo |
	rules := self rules collect: [ :each | each new ].
	rule := rules detect: [ :each | each isKindOf: aClass ] ifNone: [ self error: aClass name , ' is not a slime rule' ].
	self assert: (rule name isString and: [ rule name notEmpty ]) description: aClass name , ' has no name'.
	self
		assert: (rule rationale isString and: [ rule rationale notEmpty and: [ rule rationale endsWithSubCollection: '.' ] ])
		description: aClass name , ' has no rationale'.
	composite := RBCompositeLintRule rules: rules name: 'Slime'.
	undo := model changes execute.
	[ 
	RBSmalllintChecker runRule: composite onEnvironment: environment.
	rules
		do: [ :each | 
			self
				assert: (rule = each or: [ each result isEmpty or: [ each changes isEmpty ] ])
				description: each name , ' should not report errors' ].
	aBlock value: rule value: rules ]
		ensure: [ undo execute ].
	^ rule
]

{ #category : #'as yet unclassified' }
SeasideGettextSlimeTests >> runTransformation: aClass changes: aCollection [
	| expected |
	expected := aCollection collect: [ :each | RBParser parseMethod: each ].
	self
		run: aClass
		do: [ :rule :rules | 
			rule changes
				do: [ :change | 
					self
						assert: (expected anySatisfy: [ :parseTree | change parseTree = parseTree ])
						description: change selector , ' should not be transformed' ].
			expected
				do: [ :parseTree | 
					self
						assert: (rule changes anySatisfy: [ :change | change parseTree = parseTree ])
						description: parseTree selector , ' should be transformed' ] ]
]

{ #category : #'as yet unclassified' }
SeasideGettextSlimeTests >> setUp [
	super setUp.
	model := RBNamespace new.
	environment := RBClassEnvironment new
]

{ #category : #'as yet unclassified' }
SeasideGettextSlimeTests >> tearDown [
	super tearDown.
	Smalltalk organization removeCategory: self category
]
