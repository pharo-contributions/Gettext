accessing
matchedSystemCategories
	^SystemOrganization categories 
		select: [:cat | self includesCategory: cat]