accessing
availableLanguageLocaleIDs
	"GetTextTranslator availableLanguageLocaleIDs"

	| ids dirs localeDirForLang directoryNames |
	ids := Set new.
	dirs := Set new.
	dirs addAll: LocaleDirsForDomain values.
	dirs addAll: self defaultLocaleDirs.
	dirs
		do: [ :dir | 
			| localesDir |
			localesDir := dir asFileReference ensureCreateDirectory.
			directoryNames := [ localesDir directoryNames ]
				on: DirectoryDoesNotExist
				do: [ :e | #() ].
			directoryNames
				do: [ :langDirName | 
					| localeID |
					localeID := LocaleID posixName: langDirName.
					localeDirForLang := (localesDir fullName , '/' , (self langDirNameForLocaleID: localeID)) asFileReference ensureCreateDirectory.
					localeDirForLang ifNotNil: [ (localeDirForLang filesMatching: '*.mo') ifNotEmpty: [ ids add: localeID ] ] ] ].
	^ ids