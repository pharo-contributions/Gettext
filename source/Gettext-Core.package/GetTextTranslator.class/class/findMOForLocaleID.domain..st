private
findMOForLocaleID: id domain: aDomainName
	| sepa langSubDir path |
	sepa := FileSystem disk delimiter asString.
	langSubDir := self langDirNameForLocaleID: id.
	(self localeDirsForDomain: aDomainName)
		do: [:each |
			path := each , sepa , langSubDir, sepa , (self moNameForDomain: aDomainName).
			[(path asFileReference exists)
				 ifTrue: [^path]] on: InvalidDirectoryError do: [:e | ^nil]].
	^nil.