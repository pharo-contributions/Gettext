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
	dirName := 'po', FileDirectory slash, domain.
	pathName := dirName , FileDirectory slash , fileName.
	(FileDirectory default directoryNamed: dirName) assureExistence.
	^ pathName