private
exportPhrase: phraseString translation: translationString 
	| normalizedTrans tmp transStartsWithCR transEndsWithCR|
	phraseString isEmpty
		ifTrue: [^ self].
	self exportTag: 'msgid' msg: phraseString.
	translationString size = 0 ifTrue: [
		normalizedTrans := ''
	] ifFalse: [
		transEndsWithCR := translationString last = (Character cr).
		phraseString last = (Character cr) ifTrue: [
			transEndsWithCR ifTrue: [
				normalizedTrans := translationString
			] ifFalse: [
				normalizedTrans :=  translationString , String cr
			]
		] ifFalse: [
			transEndsWithCR ifTrue: [
				normalizedTrans := translationString allButLast
			] ifFalse: [
				normalizedTrans := translationString
			]
		].
		transStartsWithCR := normalizedTrans first = (Character cr).
		phraseString first = (Character cr) ifTrue: [
			transStartsWithCR ifFalse: [
				tmp := (Character cr asString) , normalizedTrans.
				normalizedTrans := tmp.
			]
		] ifFalse: [
			transStartsWithCR ifTrue: [
				normalizedTrans := normalizedTrans allButFirst
			]
		]
	].
	self exportTag: 'msgstr' msg: normalizedTrans.
	stream cr