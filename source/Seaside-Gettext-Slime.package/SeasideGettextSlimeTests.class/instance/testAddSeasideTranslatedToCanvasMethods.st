as yet unclassified
testAddSeasideTranslatedToCanvasMethods
	| class aMethodSelector result randomSelectors |
	class := self defineClass: #WAGettextMockObject superclass: #WAComponent.
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
			self runTransformation: WAAddSeasideTranslated changes: result.
			self removeMethodsNamedAfter: aMethodSelector in: class ]