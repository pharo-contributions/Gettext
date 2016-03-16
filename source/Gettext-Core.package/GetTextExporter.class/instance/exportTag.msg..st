private
exportTag: tag msg: aString 
	| pos end line |
	(aString indexOf: Character cr)
			= 0
		ifTrue: [self exportTag: tag singleLine: aString]
		ifFalse: [self exportTag: tag singleLine: ''.
			pos := 1.
			end := 0.
			[end < aString size]
				whileTrue: [end := aString indexOf: Character cr startingAt: pos.
					end = 0
						ifTrue: [end := aString size].
					line := aString copyFrom: pos to: end.
					stream nextPut: $";
						
						nextPutAll: (self formatString: line);
						 nextPut: $";
						 cr.
					pos := end + 1]]