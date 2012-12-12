as yet unclassified
compileMethodsIn: class
	self compile: 'renderHi:html html render: ''hi''' in: class.
	self compile: 'renderHeyYou:html html render: ''hey'', ''you''' in: class.
	self compile: 'renderHeyYouTwo:html html render: ''hey'', self you' in: class.
	self compile: 'you ^''you''' in: class