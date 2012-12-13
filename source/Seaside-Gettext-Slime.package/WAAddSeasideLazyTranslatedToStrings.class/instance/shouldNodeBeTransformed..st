as yet unclassified
shouldNodeBeTransformed: node
	"self haltIf:[node value = 'you']."
	^ self classIsNotWAPainterSubclass
		and: [ (self nodeIsInterestingString: node) and: [ self parentsDoNotSendMethodToIgnore: node ] ]