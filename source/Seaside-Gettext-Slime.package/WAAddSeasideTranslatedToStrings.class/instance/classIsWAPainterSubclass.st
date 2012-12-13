as yet unclassified
classIsWAPainterSubclass
	^ (class name = #WAGettextMockComponent and: [ class name ~= #WAGettextMockObject ])
		or: [ InterestingSubclasses includes: class ]