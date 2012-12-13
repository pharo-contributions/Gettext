as yet unclassified
testRenderToTranslate
	| class renderMethod result |
	class := self mockComponent.
	renderMethod := 'render:'.
	result := 'render' , renderMethod allButLast capitalized , 'Hi:html html translate:''hi''.'.
	self compileMethodsUsing: renderMethod in: class.
	self runTransformation: WAReplaceLiteralStringRenderMethodsWithTranslate changes: {result}