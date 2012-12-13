as yet unclassified
classIsNotWAPainterSubclass
	^ class name = #WAGettextMockObject
		and: [ class name ~= #WAGettextMockComponent or: [ (InterestingSubclasses includes: class) not ] ]