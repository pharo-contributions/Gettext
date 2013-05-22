private
moFileForDomain: domainName
	"Returns the cached MOFile for the given domainName (or nil).
	If none is cached, it will try to load one (every time) and cache it on demand."
	| moFile |

	^moFiles 
		at: domainName 
		ifAbsent: [
			moFile := self loadMOFileForDomain: domainName.
			moFile notNil ifTrue:[
				moFiles at: domainName put: moFile].
			moFile]