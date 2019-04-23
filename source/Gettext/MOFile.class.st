"
Wrapper for MO file of gettext.
Known limitation:  
	currently don't support prural form.
	translation strings have to be encoded in utf-8.

Implementation notes:
	Testing on XO showed emulation of hash search without plugin + on demand loading is slow.
	The test also showed conversion of utf8 string to Squeak's String is really slow (especially for non-latin language).
	so in this version, all of original/translated strings are loaded on initiaization,
	but ""translated strings"" is left as ByteString on loading time, to reduce loading time.
	After that the translated string is converted on demand. 

"
Class {
	#name : #MOFile,
	#superclass : #Object,
	#instVars : [
		'localeID',
		'fileName',
		'isLittleEndian',
		'magic',
		'revision',
		'nStrings',
		'originalTableOffset',
		'translatedTableOffset',
		'hashTableSize',
		'hashTableOffset',
		'hashTable',
		'originalStrings',
		'translatedStrings',
		'translations'
	],
	#classVars : [
		'Cr',
		'Lf'
	],
	#category : 'Gettext'
}

{ #category : #'instance creation' }
MOFile class >> fileName: path localeID: id [
	^self new 
			load:path localeID: id
]

{ #category : #'class initialization' }
MOFile class >> initialize [
	Cr := Character cr.
	Lf := Character lf.

]

{ #category : #public }
MOFile >> atRandom [

	^translatedStrings at: nStrings atRandom.

]

{ #category : #public }
MOFile >> fileName [
	^fileName
]

{ #category : #public }
MOFile >> fileName: path [
	fileName := path
]

{ #category : #experimental }
MOFile >> hashPjw: aString [
	"This is the hash function used by the (unused) hashTable. Kept in case someone wants to try and make it work"
	"So called `hashpjw' function by P.J. Weinberger
   	[see Aho/Sethi/Ullman, COMPILERS: Principles, Techniques and Tools,
   	1986, 1987 Bell Telephone Laboratories, Inc.] "
	| stringSize hash g |
	stringSize := aString size.
	hash := 0.
	1 to: stringSize do: [:pos |
		hash := hash bitShift: 4.
		hash := hash + ((aString at: pos) asInteger).
		g := hash bitAnd: 16rF0000000.
		g = 0 ifFalse: [
			hash := hash  bitXor: (g bitShift: -24).
			hash := hash bitXor: g.
		]
	].
	^hash.

]

{ #category : #public }
MOFile >> load: aFileName localeID: id [
	"all of strings are loaded. 
	translation strings are converted to internal string format on load time.
	original-string/index pairs are registerd to Dictionary on load time."
	localeID := id.
	FileStream readOnlyFileNamed: aFileName do: [:strm | |originalTable translatedTable|
	fileName := aFileName.
	self loadHeader: strm.
	
	originalTable := self loadStringPointers: strm 
									offset: originalTableOffset.
									
	translatedTable := self loadStringPointers: strm 
										offset: translatedTableOffset.

	originalStrings := self loadStrings: strm 
							pointers: originalTable.

	translatedStrings := self loadStrings: strm 
								pointers: translatedTable.

	translations := Dictionary new: nStrings.  
	1 to: nStrings do: [:index |
		| key |
		key := originalStrings at: index.
		translations at: key put: index.].
	
	originalStrings := nil] 
]

{ #category : #private }
MOFile >> loadHeader: strm [
	strm binary.
	magic :=  strm uint32.
	magic = 16rDE120495 
		ifTrue: [isLittleEndian := true]
		ifFalse: [
			magic = 16r950412DE 
				ifTrue: [isLittleEndian := false]
				ifFalse: [ self error: 'invalid MO']
		].
	revision := self nextInt32From: strm.
	nStrings := self nextInt32From: strm.
	originalTableOffset := self nextInt32From: strm.
	translatedTableOffset := self nextInt32From: strm.
	hashTableSize := self nextInt32From: strm.
	hashTableOffset := self nextInt32From: strm.

]

{ #category : #private }
MOFile >> loadStringPointers: strm offset: tableOffset [
	"returns tupple {arrayOfOffsetToString  arrayOfLengthOfString}"
	| offsetTable lenTable len offset tupple |
	offsetTable := IntegerArray new: nStrings.
	lenTable := IntegerArray new: nStrings.
	strm binary.
	strm position: tableOffset.
	1 to: nStrings do: [:index |
		len := self nextInt32From: strm.
		offset := self nextInt32From: strm.
		offsetTable at: index put: offset.
		lenTable at: index put: len.
	].
	tupple := Array new: 2.
	tupple at: 1 put: offsetTable.
	tupple at: 2 put:  lenTable.
	^tupple

]

{ #category : #private }
MOFile >> loadStrings: strm pointers: table [
	"We convert string encoding at load time.
	Currently, we do not take care to set the leadingChar for a languageEnvironment"
	^self loadStrings: strm pointers: table encoding: #utf8 languageEnvironment: nil

]

{ #category : #private }
MOFile >> loadStrings: strm pointers: tupple encoding: encodingName languageEnvironment: env [
	| offsetTable lenTable strings |
	strm ascii; 
		converter: (TextConverter newForEncoding: encodingName).
	offsetTable :=  tupple first.
	lenTable := tupple second.
	strings := Array new: nStrings.
	1 to: nStrings do: [:index | |  rawStr start byteLength endPos|
		start := offsetTable at: index.
		byteLength := lenTable at: index.
		endPos := start + byteLength.
		rawStr :=  (String new: byteLength) writeStream.
		strm position:  start.
		[strm position < endPos] whileTrue: [rawStr nextPut: strm next].
		strings at: index put: rawStr contents.
		

	].
	^strings.
]

{ #category : #private }
MOFile >> nextInt32From: strm [
	^isLittleEndian 
			ifTrue: [^strm nextLittleEndianNumber: 4]
			ifFalse: [^strm nextInt32]
]

{ #category : #public }
MOFile >> searchFor: aString [
	| index |
	index := translations at: aString ifAbsent: [^nil].
	^translatedStrings at: index.
	

]

{ #category : #public }
MOFile >> translationFor: aString [ 
	aString size = 0 ifTrue: [^ '']. "Gettext header"
	^ (self searchFor: aString) ifNil: [aString]

]
