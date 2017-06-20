accessing
availableForLocaleID: localeID
	"Answer available locale ID.
	If translator is not found for correct locale ID, then isoLanguage is
	attempted for the key."

	^ self translators
		at: localeID
		ifAbsent: [ localeID hasParent
				ifTrue: [ self translators at: localeID parent ifAbsent: [ self default ] ]
				ifFalse: [ self default ] ]