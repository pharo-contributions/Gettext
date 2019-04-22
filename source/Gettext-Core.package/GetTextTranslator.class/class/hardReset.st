actions
hardReset
	"Flush all remembered stuff.
	Load new translators (based on the files currently found)"	
	
	SystemDefaultLocaleDirs := OrderedCollection new.
	UserDefaultLocaleDirs := OrderedCollection new.
	LocaleDirsForDomain := Dictionary new.
	Translators := nil.

	self createAvailableTranslators 
	