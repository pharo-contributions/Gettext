translation data layout
localeDirsForDomain: aDomainName
	"returns collection of locale directories for text domain.  
	This includes user defined one for the domain, user defaults and system defaults" 
	| dirs dir |
	dirs := OrderedCollection new.
	dir := self localeDirForDomain: aDomainName.
	dir ifNotNil: [dirs add: dir].
	dirs addAll:  self defaultLocaleDirs.
	^dirs