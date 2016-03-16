accessing
registerCategoryPrefix: aString domain: aDomainName
	| domInfo |
	domInfo := self domainInfoFor: aDomainName.
	domInfo categoryPrefixes add: aString.
	self refresh.