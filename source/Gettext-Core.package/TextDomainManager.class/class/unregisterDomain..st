accessing
unregisterDomain: domainName
	DomainInfos removeKey: domainName.
	self refresh.
	NaturalLanguageTranslator domainUnregistered: domainName.
