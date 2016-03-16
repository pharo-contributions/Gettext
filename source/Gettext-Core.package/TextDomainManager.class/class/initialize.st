class initialization
initialize
	"	TextDomainManager initialize	"

	ClassCategories := IdentityDictionary new.
	Classes := IdentityDictionary new.
	LoneClasses := IdentityDictionary new.
	DomainInfos := Dictionary new.
	self defaultDomain: 'pharo'.