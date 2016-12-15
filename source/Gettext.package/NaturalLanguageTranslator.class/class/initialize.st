class initialization
initialize
	(Smalltalk classNamed: #SessionManager)
		ifNotNil: [:sessionManagerClass|
			sessionManagerClass default
				registerSystemClassNamed: self name
				atPriority: 100]
		ifNil: [Smalltalk addToStartUpList: NaturalLanguageTranslator after: FileLocator].
	
	