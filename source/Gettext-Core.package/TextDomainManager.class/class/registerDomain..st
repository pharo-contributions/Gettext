accessing
registerDomain: domainName
	| domInfo |
	domInfo := TextDomainInfo new.
	DomainInfos at: domainName put: domInfo.
	GetTextTranslator domainRegistered: domainName.
	^domInfo