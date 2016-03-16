translation
translate: aString inDomain: aDomainName
	| mo |
	mo := self moFileForDomain: aDomainName.
	^mo isNil 
		ifTrue: [aString] 
		ifFalse: [mo translationFor: aString]
