accessing
atRandom

	| v |
	moFiles ifEmpty: [^ ''].
	(v := moFiles atRandom value) ifNil: [^ ''].
	^ v atRandom.
