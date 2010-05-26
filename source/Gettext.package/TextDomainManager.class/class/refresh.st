private
refresh
	ClassCategories := IdentityDictionary new.
	Classes := IdentityDictionary new.
	DomainInfos keysAndValuesDo: [:domainName :domainInfo |
		domainInfo matchedSystemCategories do: [:cat |
			ClassCategories at: cat ifPresent: [self error: 'category ', (cat asString) , '  belongs to multiple domains'].
			ClassCategories at: cat put: domainName.
			(SystemOrganization listAtCategoryNamed: cat ) do: [ :cls |
				Classes at: cls put: domainName.
			]
		]
	].
	Classes addAll: LoneClasses.