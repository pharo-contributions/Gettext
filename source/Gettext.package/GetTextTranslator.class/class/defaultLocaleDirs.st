translation data layout
defaultLocaleDirs
	| dirs |
	dirs := OrderedCollection new.
	UserDefaultLocaleDirs ifNotNil: [dirs addAll: UserDefaultLocaleDirs].
	dirs addAll: self systemDefaultLocaleDirs.
	^dirs
