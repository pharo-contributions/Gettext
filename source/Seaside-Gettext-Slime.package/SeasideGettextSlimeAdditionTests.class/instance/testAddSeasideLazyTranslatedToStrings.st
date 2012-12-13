as yet unclassified
testAddSeasideLazyTranslatedToStrings
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