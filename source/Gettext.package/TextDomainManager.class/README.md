I manages mapping from class category to textdomain.

Class variables:
 ClassCategories	IdentityDictionary -- classCategory -> domainName 
 Classes			IdentityDictionary -- class name (a Symbol) -> domainName   (a cache only!)
 DefaultDomain	String -- the default domain name
 DomainInfos		Dictionary -- domainName -> a TextDomainInfo
 LoneClasses		IdentityDictionary -- class name (a Symbol) -> domainName.  For classes whose entire category are not all in the same domain (BookMorph and QuickGuideMorph)

TextDomainManager registerCategoryPrefix: 'DrGeoII' domain: 'DrGeoII'.
TextDomainManager unregisterDomain: 'DrGeoII'.

TextDomainManager registerClass: #QuickGuideMorph domain: 'quickguides'.
TextDomainManager registerClass: #QuickGuideHolderMorph  domain: 'quickguides'.
