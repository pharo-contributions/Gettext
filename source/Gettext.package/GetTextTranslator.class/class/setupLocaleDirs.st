translation data layout
setupLocaleDirs
	| dirs sepa localesDirName |
	sepa := FileDirectory slash.
	SystemDefaultLocaleDirs := nil.
	dirs := self systemDefaultLocaleDirs.
	localesDirName := 'locale'.
	dirs add:  (SmalltalkImage current imagePath) , sepa , localesDirName.
	dirs add:  (SmalltalkImage current vmPath) , sepa , localesDirName.
	^dirs