accessing
registerDomain: domainName
	| domInfo |
	domInfo := TextDomainInfo new.
	DomainInfos at: domainName put: domInfo.
	NaturalLanguageTranslator domainRegistered: domainName.
	^domInfo