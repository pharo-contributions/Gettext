translation data layout
setupLocaleDirs
	| dirs sepa localesDirName |
	sepa := FileSystem disk delimiter asString.
	SystemDefaultLocaleDirs := nil.
	dirs := self systemDefaultLocaleDirs.
	localesDirName := 'locale'.
	dirs add:  (Smalltalk imageDirectory fullName) , sepa , localesDirName.
	dirs add:  (Smalltalk vm path) , sepa , localesDirName.
	^dirs