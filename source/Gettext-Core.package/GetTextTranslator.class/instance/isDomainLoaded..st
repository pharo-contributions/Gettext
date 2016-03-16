accessing
isDomainLoaded: aDomainName
	| mo |
	mo := moFiles at: aDomainName ifAbsent: [nil].
	^mo isNil not.
