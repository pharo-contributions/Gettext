as yet unclassified
shouldNodeBeTransformed: node

	^ self classIsNotWAPainterSubclass
		and: [ (self nodeIsInterestingString: node) and: [ 	 self parentsDoNotSendMethodToIgnore: node ] ]