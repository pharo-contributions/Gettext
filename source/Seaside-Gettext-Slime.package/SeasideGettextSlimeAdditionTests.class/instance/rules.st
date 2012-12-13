as yet unclassified
rules
	^ OrderedCollection new
		addAll: WAGettextSlimeTransformationRule allSubclasses;
		yourself