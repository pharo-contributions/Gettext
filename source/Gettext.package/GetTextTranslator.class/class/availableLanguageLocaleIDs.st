accessing
availableLanguageLocaleIDs
	"GetTextTranslator availableLanguageLocaleIDs"
	| ids dirs localeDirForLang directoryNames |
	ids := Set new.
	dirs := Set new.
	dirs addAll: LocaleDirsForDomain values.
	dirs addAll: self defaultLocaleDirs.
	dirs do: [:dir |
		| localesDir |
		localesDir := FileDirectory on: dir. 
		directoryNames := [localesDir directoryNames] on: InvalidDirectoryError do: [:e | #()].
		directoryNames
				do: [:langDirName | 
					| localeID  |
					localeID := LocaleID posixName: langDirName.
					localeDirForLang := localesDir directoryNamed: (self langDirNameForLocaleID: localeID).
					localeDirForLang ifNotNil: [
						(localeDirForLang fileNamesMatching: '*.mo') ifNotEmpty: [ids add: localeID]
					]
				].
	].
	^ids