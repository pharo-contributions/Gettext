translation data layout
setLocaleDir: path forDoamin: aDomainName
	self LocaleDirsForDomain
		at: aDomainName
		put: path.