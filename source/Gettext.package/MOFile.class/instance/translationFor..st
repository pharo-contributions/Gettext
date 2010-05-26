public
translationFor: aString 
	aString size = 0 ifTrue: [^ '']. "Gettext header"
	^ (self searchFor: aString) ifNil: [aString]
