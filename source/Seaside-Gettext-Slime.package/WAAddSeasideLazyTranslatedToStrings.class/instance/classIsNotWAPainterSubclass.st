as yet unclassified
classIsNotWAPainterSubclass
	^ class name = #WAGettextMockObject
		or: [ class name ~= #WAGettextMockComponent and: [ (InterestingSubclasses includes: class) not ] ]