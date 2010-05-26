private
findMOForLocaleID: id domain: aDomainName
	| sepa langSubDir path |
	sepa := FileDirectory slash.
	langSubDir := self langDirNameForLocaleID: id.
	(self localeDirsForDomain: aDomainName)
		do: [:each |
			path := each , sepa , langSubDir, sepa , (self moNameForDomain: aDomainName).
			[(FileDirectory default fileExists: path)
				 ifTrue: [^path]] on: InvalidDirectoryError do: [:e | ^nil]].
	^nil.