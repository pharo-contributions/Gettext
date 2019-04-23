translation
translate: aString inDomain: aDomainName

	| mo result |

	mo := self moFileForDomain: aDomainName.
	result := mo isNil 
		ifTrue: [ GetTextUnsucessfulTranslationResult original: aString] 
		ifFalse: [ mo translationFor: aString ].

	^ (result isSuccessful not and: [ self localeID isoCountry notNil ])
		ifTrue: [ self translateIgnoringCountry: aString inDomain: aDomainName ]
		ifFalse: [ result translation ]
