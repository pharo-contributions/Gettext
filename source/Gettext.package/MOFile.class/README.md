Wrapper for MO file of gettext.
Known limitation:  
	currently don't support prural form.
	translation strings have to be encoded in utf-8.

Implementation notes:
	Testing on XO showed emulation of hash search without plugin + on demand loading is slow.
	The test also showed conversion of utf8 string to Squeak's String is really slow (especially for non-latin language).
	so in this version, all of original/translated strings are loaded on initiaization,
	but "translated strings" is left as ByteString on loading time, to reduce loading time.
	After that the translated string is converted on demand. 
