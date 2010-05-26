private
translationFor: aKey in: translator
	translator ifNil: [^''].
	translator translations at: aKey ifPresent: [:s | ^s].
	"If we have old camelCase translations, make space-separated words"
	translator translations at: aKey toCamelCase ifPresent: [:s | 
		(s includes: Character space) ifTrue: [^s].
		^s fromCamelCase].
	^''