accessing
loadMOFiles
	TextDomainManager allKnownDomains 
		do: [:domainName |
			self moFileForDomain: domainName
		].