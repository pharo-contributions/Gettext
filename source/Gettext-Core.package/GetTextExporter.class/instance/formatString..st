private
formatString: aString 
	| result |
	result := aString.
	self formatReplacements
		do: [:each | result := result copyReplaceAll: each key with: each value].
	^ result