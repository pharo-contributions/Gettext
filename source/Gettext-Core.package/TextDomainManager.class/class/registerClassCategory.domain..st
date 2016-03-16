accessing
registerClassCategory: categorySymbol domain: aDomainName
	| domInfo |
	domInfo := self domainInfoFor: aDomainName.
	domInfo categories add: categorySymbol.
	self refresh.
