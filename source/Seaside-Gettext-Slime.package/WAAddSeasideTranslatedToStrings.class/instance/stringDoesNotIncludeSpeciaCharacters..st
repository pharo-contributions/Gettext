testing
stringDoesNotIncludeSpeciaCharacters: aString
	#($@)
		do: [ :eachCharacter | 
			(aString includes: eachCharacter)
				ifTrue: [ ^ false ] ].
	^ true