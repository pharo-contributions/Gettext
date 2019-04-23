translation
translateIgnoringCountry: aString inDomain: aDomainName

	"try tranlation ignoring the country information in my locale"

	| languageLocale newTranslator |
	languageLocale := LocaleID isoLanguage: self localeID isoLanguage.
	newTranslator := GetTextTranslator availableForLocaleID: languageLocale.
	^ newTranslator translate: aString inDomain: aDomainName
