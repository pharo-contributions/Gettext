"
I hold criteria for deciding wheter a systemCategory belongs to domain. 
- categoryPrefixes is collection of prefix of class category.
- categories is for specifying fine grained criterion.

"
Class {
	#name : #TextDomainInfo,
	#superclass : #Object,
	#instVars : [
		'categoryPrefixes',
		'categories'
	],
	#category : 'Gettext'
}

{ #category : #accessing }
TextDomainInfo >> categories [
	^categories
]

{ #category : #private }
TextDomainInfo >> category: categoryName matches: prefix [
	^ categoryName notNil and: [categoryName = prefix or: [categoryName beginsWith: prefix, '-']]
]

{ #category : #accessing }
TextDomainInfo >> categoryPrefixes [
	^categoryPrefixes
]

{ #category : #accessing }
TextDomainInfo >> includesCategory: categorySymbol [
	(categories includes: categorySymbol) ifTrue: [^true].
	categoryPrefixes do: [:each |
		(self category: categorySymbol matches: each) ifTrue: [^true]
	].

	^false.
]

{ #category : #'initialize-release' }
TextDomainInfo >> initialize [
	categoryPrefixes := Set new.
	categories := IdentitySet new.

]

{ #category : #accessing }
TextDomainInfo >> matchedSystemCategories [
	^SystemOrganization categories 
		select: [:cat | self includesCategory: cat]
]
