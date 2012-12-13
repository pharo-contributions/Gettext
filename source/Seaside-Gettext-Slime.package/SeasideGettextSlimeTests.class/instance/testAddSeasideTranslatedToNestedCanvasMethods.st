as yet unclassified
testAddSeasideTranslatedToNestedCanvasMethods
	| class aMethodSelector result randomSelectors |
	class := self defineClass: #WAGettextMockObject superclass: #WAComponent.
	result := OrderedCollection new.
	result add: 'renderContentOn: html html listItem:[ html label class:''1234''; with:''acbd'' seasideTranslated]'.
	self compile: 'renderContentOn: html html listItem:[ html label class:''1234''; with:''acbd'']' in: class.
	self runTransformation: WAAddSeasideTranslatedInMethodsWithHtmlCanvasSelectors changes: result