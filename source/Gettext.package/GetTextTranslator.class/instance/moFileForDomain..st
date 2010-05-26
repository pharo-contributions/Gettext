private
moFileForDomain: domainName
	^moFiles at: domainName ifAbsentPut: [self loadMOFileForDomain: domainName]