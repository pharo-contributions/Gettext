printing
printOn: aStream
	aStream nextPutAll: self class name; nextPut: $(; print: self localeID; nextPut: $)