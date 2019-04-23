Class {
	#name : #SeasideGettextSlimeRemovalTests,
	#superclass : #SeasideGettextSlimeTests,
	#category : 'Seaside-Gettext-Slime-Tests'
}

{ #category : #'as yet unclassified' }
SeasideGettextSlimeRemovalTests >> rules [
	^ OrderedCollection new
		add: WARemoveTranslatedSends;
		yourself
]

{ #category : #'as yet unclassified' }
SeasideGettextSlimeRemovalTests >> testRemoveTranslatedSends [
	| class aMethodSelector result randomSelectors |
	class := self mockComponent.
	result := OrderedCollection new.
	result add: 'you ^''you'''.
	result add: 'youYou ^''you'' , ''you'''.
	result add: 'youOneYou ^''you'' , 1 greaseString , ''you'''.
	result
		add: 'youFromStream ^ String streamContents: [:s | s nextPutAll: ''You'' ; nextPut: $a; nextPutAll: ''fromStream'']'.
	self compile: 'you ^ ''you'' translated' in: class.
	self compile: 'youYou ^ ''you'' translated , ''you'' translated' in: class.
	self compile: 'youOneYou ^ ''you'' translated, 1 greaseString , ''you'' translated' in: class.
	self
		compile:
			'youFromStream ^ String streamContents: [:s | s nextPutAll: ''You'' translated; nextPut: $a; nextPutAll: ''fromStream'' translated]'
		in: class.
	self runTransformation: WARemoveTranslatedSends changes: result
]
