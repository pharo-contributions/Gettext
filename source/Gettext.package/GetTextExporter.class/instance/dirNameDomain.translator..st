exporting
dirNameDomain: domain translator: translator 
	"Answer a file name for the domain. Make one if it is not exist yet.
	Make template file name if translator is nil"
	"self new dirNameDomain: 'etoys' translator:
	NaturalLanguageTranslator current"
	"self new dirNameDomain: 'etoys' translator: nil"
	| fileName dirName pathName |
	"safeCategory := category copyReplaceAll: ' ' with: ':='."
	fileName := translator
				ifNil: [domain , '.pot']
				ifNotNil: [translator localeID posixName , '.po'].
	dirName := 'po', FileSystem disk delimiter asString , domain.
	pathName := dirName ,  FileSystem disk delimiter asString , fileName.
	(dirName asFileReference ensureDirectory).
	^ pathName