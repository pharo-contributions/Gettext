class initialization
startUp: resuming 
	resuming
		ifFalse: [^ self].
	self privateStartUp.