experimental
hashPjw: aString
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
