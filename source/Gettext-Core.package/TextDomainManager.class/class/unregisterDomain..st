accessing
unregisterDomain: domainName
	DomainInfos removeKey: domainName.
	self refresh.
	GetTextTranslator domainUnregistered: domainName.
