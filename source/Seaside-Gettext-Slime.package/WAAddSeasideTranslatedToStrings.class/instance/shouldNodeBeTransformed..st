as yet unclassified
shouldNodeBeTransformed: node
	^ self classIsWAPainterSubclass
		and: [ (self nodeIsInterestingString: node) and: [ self parentsDoNotSendMethodToIgnore: node ] ]