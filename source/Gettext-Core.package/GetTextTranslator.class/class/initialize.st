class initialization
initialize
	GRPlatform current addToStartUpList: self.
	SystemDefaultLocaleDirs := OrderedCollection new.
	UserDefaultLocaleDirs := OrderedCollection new.
	LocaleDirsForDomain := Dictionary new.