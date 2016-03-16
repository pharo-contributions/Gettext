exporting
dirNameCategory: category translator: translator 
	"Answer a file name for the category. Make one if it is not exist yet.
	Make template file name if translator is nil"
	"self new dirNameCategory: 'Morphic-Scripting Support' translator:
	NaturalLanguageTranslator current"
	"self new dirNameCategory: 'Morphic-Scripting Support' translator: nil"
	| safeCategory fileName dirName pathName |
	safeCategory := category copyReplaceAll: ' ' with: ':='.
	fileName := translator
				ifNil: [safeCategory , '.pot']
				ifNotNil: [translator localeID posixName , '.po'].
	dirName := (safeCategory findTokens: '-')
				inject: 'po'
				into: [:aString :next | aString , FileSystem disk delimiter asString , next].
	pathName := dirName , FileSystem disk delimiter asString , fileName.
	(dirName asFileReference ensureCreateDirectory).
	^ pathName