as yet unclassified
testAddSeasideTranslatedToStrings
	| class aMethodSelector result randomSelectors |
	class := self defineClass: #WAGettextMockObject superclass: #WAComponent.
	result := OrderedCollection new.
	result add: 'you ^''you'' seasideTranslated'.
	result add: 'youYou ^''you'' seasideTranslated , ''you'' seasideTranslated'.
	result add: 'youOneYou ^''you'' seasideTranslated , 1 greaseString , ''you'' seasideTranslated'.
	result
		add:
			'youFromStream ^ String streamContents: [:s | s nextPutAll: ''you'' seasideTranslated ; nextPut: $a; nextPutAll: ''you'' seasideTranslated]'.
	self compile: 'you ^ ''you''' in: class.
	self compile: 'youYou ^ ''you'' , ''you''' in: class.
	self compile: 'youOneYou ^ ''you'' , 1 greaseString , ''you''' in: class.
	self
		compile: 'youFromStream ^ String streamContents: [:s | s nextPutAll: ''you''; nextPut: $a; nextPutAll: ''you'']'
		in: class.
	self runTransformation: WAAddSeasideTranslatedToStrings changes: result