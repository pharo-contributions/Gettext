as yet unclassified
compileMethodsUsing: aMethodSelector in: class
	self compile: (self renderMethodOne: aMethodSelector) in: class.
	self compile: (self renderMethodTwo: aMethodSelector) in: class.
	self compile: (self renderMethodThree: aMethodSelector) in: class.
	self compile: 'you ^''you''' in: class