private
domainInfoFor: domainName
	^DomainInfos at: domainName ifAbsentPut: [ self registerDomain: domainName]