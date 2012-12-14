as yet unclassified
doesNotContainNameFragments: aNode
	^ checkForMethodNameFragments
		ifTrue: [ self methodNameFragmentsToIgnore allSatisfy: [ :eachRegex | (aNode selector asString matchesRegex: eachRegex) not  ]]
		ifFalse: [ true ]