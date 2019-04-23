Class {
	#name : #SeasideGettextSlimeAdditionTests,
	#superclass : #SeasideGettextSlimeTests,
	#category : 'Seaside-Gettext-Slime-Tests'
}

{ #category : #'as yet unclassified' }
SeasideGettextSlimeAdditionTests >> compileMethodsUsing: aMethodSelector in: class [
	self compile: (self renderMethodOne: aMethodSelector) in: class.
	self compile: (self renderMethodTwo: aMethodSelector) in: class.
	self compile: (self renderMethodThree: aMethodSelector) in: class
]

{ #category : #convenience }
SeasideGettextSlimeAdditionTests >> interestingCanvasSelectors [
	^WAAddSeasideTranslatedInMethodsWithHtmlCanvasSelectors selectorsOfInterest 
]

{ #category : #'as yet unclassified' }
SeasideGettextSlimeAdditionTests >> removeMethodsNamedAfter: aMethodSelector in: class [
	class removeMethod: ('render' , aMethodSelector allButLast capitalized , 'Hi:') asSymbol.
	class removeMethod:('render' , aMethodSelector allButLast capitalized , 'HeyYou:') asSymbol.
	class removeMethod: ('render' , aMethodSelector allButLast capitalized , 'HeyYouTwo:') asSymbol
]

{ #category : #'as yet unclassified' }
SeasideGettextSlimeAdditionTests >> renderMethodOne: aMethodSelector [
	^ 'render' , aMethodSelector allButLast capitalized , 'Hi:html html ' , aMethodSelector , ' ''hi'''
]

{ #category : #'as yet unclassified' }
SeasideGettextSlimeAdditionTests >> renderMethodThree: aMethodSelector [
	^ 'render' , aMethodSelector allButLast capitalized , 'HeyYouTwo:html html ' , aMethodSelector , ' ''hey'', self you'
]

{ #category : #'as yet unclassified' }
SeasideGettextSlimeAdditionTests >> renderMethodTwo: aMethodSelector [
	^ 'render' , aMethodSelector allButLast capitalized , 'HeyYou:html html ' , aMethodSelector , ' ''hey'', ''you'''
]

{ #category : #'as yet unclassified' }
SeasideGettextSlimeAdditionTests >> rules [
	^ OrderedCollection new
		addAll: WAGettextSlimeTransformationRule allSubclasses;
		yourself
]

{ #category : #'as yet unclassified' }
SeasideGettextSlimeAdditionTests >> testAddSeasideLazyTranslatedToStrings [
	| class aMethodSelector result randomSelectors |
	class := self mockObject.
	result := OrderedCollection new.
	result add: 'you ^''you'' seasideLazyTranslated'.
	result add: 'youYou ^''you'' seasideLazyTranslated , ''you'' seasideLazyTranslated'.
	result add: 'youOneYou ^''you'' seasideLazyTranslated , 1 greaseString , ''you'' seasideLazyTranslated'.
	result
		add:
			'youFromStream ^ String streamContents: [:s | s nextPutAll: ''You'' seasideLazyTranslated ; nextPut: $a; nextPutAll: ''fromStream'' seasideLazyTranslated]'.
	self compile: 'you ^ ''you''' in: class.
	self compile: 'youYou ^ ''you'' , ''you''' in: class.
	self compile: 'youOneYou ^ ''you'' , 1 greaseString , ''you''' in: class.
	self
		compile:
			'youFromStream ^ String streamContents: [:s | s nextPutAll: ''You''; nextPut: $a; nextPutAll: ''fromStream'']'
		in: class.
	self runTransformation: WAAddSeasideLazyTranslatedToStrings changes: result
]

{ #category : #'as yet unclassified' }
SeasideGettextSlimeAdditionTests >> testAddSeasideTranslatedToCanvasMethods [
	| class aMethodSelector result randomSelectors |
	class := self mockComponent.
	randomSelectors := OrderedCollection new.
	3 timesRepeat: [ randomSelectors add: self interestingCanvasSelectors atRandom ].
	randomSelectors
		do: [ :each | 
			aMethodSelector := each asString.
			result := OrderedCollection new.
			result add: (self renderMethodOne: aMethodSelector) , ' seasideTranslated.'.
			result
				add:
					'render' , aMethodSelector allButLast capitalized , 'HeyYou:html html ' , aMethodSelector
						, ' ''hey'' seasideTranslated , ''you'' seasideTranslated'.
			result
				add:
					'render' , aMethodSelector allButLast capitalized , 'HeyYouTwo:html html ' , aMethodSelector
						, ' ''hey'' seasideTranslated , self you'.
			self compileMethodsUsing: aMethodSelector in: class.
			self runTransformation: WAAddSeasideTranslatedInMethodsWithHtmlCanvasSelectors changes: result.
			self removeMethodsNamedAfter: aMethodSelector in: class ]
]

{ #category : #'as yet unclassified' }
SeasideGettextSlimeAdditionTests >> testAddSeasideTranslatedToNestedCanvasMethods [
	| class aMethodSelector result randomSelectors |
	class := self mockComponent.
	result := OrderedCollection new.
	result add: 'renderContentOn: html html listItem:[ html label class:''1234''; with:''acbd'' seasideTranslated]'.
	self compile: 'renderContentOn: html html listItem:[ html label class:''1234''; with:''acbd'']' in: class.
	self runTransformation: WAAddSeasideTranslatedInMethodsWithHtmlCanvasSelectors changes: result
]

{ #category : #'as yet unclassified' }
SeasideGettextSlimeAdditionTests >> testAddSeasideTranslatedToStrings [
	| class aMethodSelector result randomSelectors |
	class := self mockComponent.
	result := OrderedCollection new.
	result add: 'you ^''you'' seasideTranslated'.
	result add: 'youYou ^''you'' seasideTranslated , ''you'' seasideTranslated'.
	result add: 'youOneYou ^''you'' seasideTranslated , 1 greaseString , ''you'' seasideTranslated'.
	result
		add:
			'youFromStream ^ String streamContents: [:s | s nextPutAll: ''You'' seasideTranslated ; nextPut: $a; nextPutAll: ''fromStream'' seasideTranslated]'.
	self compile: 'you ^ ''you''' in: class.
	self compile: 'youYou ^ ''you'' , ''you''' in: class.
	self compile: 'youOneYou ^ ''you'' , 1 greaseString , ''you''' in: class.
	self
		compile:
			'youFromStream ^ String streamContents: [:s | s nextPutAll: ''You''; nextPut: $a; nextPutAll: ''fromStream'']'
		in: class.
	self runTransformation: WAAddSeasideTranslatedToStrings changes: result
]

{ #category : #'as yet unclassified' }
SeasideGettextSlimeAdditionTests >> testRenderToTranslate [
	| class renderMethod result |
	class := self mockComponent.
	renderMethod := 'render:'.
	result := 'render' , renderMethod allButLast capitalized , 'Hi:html html translate:''hi''.'.
	self compileMethodsUsing: renderMethod in: class.
	self runTransformation: WAReplaceLiteralStringRenderMethodsWithTranslate changes: {result}
]
