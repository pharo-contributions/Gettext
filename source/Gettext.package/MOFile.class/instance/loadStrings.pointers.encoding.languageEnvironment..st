private
loadStrings: strm pointers: tupple encoding: encodingName languageEnvironment: env
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