accessing
domainForClass: aClass
	^Classes at: aClass theNonMetaClass name ifAbsent: [self defaultDomain]