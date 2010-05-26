translation data layout
localeDirForDomain: aDomainName
	"returns registered localeDirectory for the textdomain. returns nil if not registered"
	^LocaleDirsForDomain at: aDomainName ifAbsent: [nil]