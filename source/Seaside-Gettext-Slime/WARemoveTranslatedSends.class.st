Class {
	#name : #WARemoveTranslatedSends,
	#superclass : #WAGettextSlimeTransformationRule,
	#category : 'Seaside-Gettext-Slime'
}

{ #category : #'as yet unclassified' }
WARemoveTranslatedSends >> initialize [
	super initialize.
	self rewriteRule replace: '`@object translated' with: '`@object '
]

{ #category : #'as yet unclassified' }
WARemoveTranslatedSends >> name [
	^ 'Remove existing sends of #translated'
]

{ #category : #'as yet unclassified' }
WARemoveTranslatedSends >> rationale [
	^ 'We are adding #seasideTranslated to everything so the #translated sends are redundant.'
]
