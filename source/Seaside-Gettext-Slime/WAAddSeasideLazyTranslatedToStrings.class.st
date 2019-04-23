Class {
	#name : #WAAddSeasideLazyTranslatedToStrings,
	#superclass : #WAAddSeasideTranslatedToStrings,
	#category : 'Seaside-Gettext-Slime'
}

{ #category : #'as yet unclassified' }
WAAddSeasideLazyTranslatedToStrings >> classIsNotWAPainterSubclass [
	^ class name = #WAGettextMockObject
		or: [ class name ~= #WAGettextMockComponent and: [ (InterestingSubclasses includes: class) not ] ]
]

{ #category : #'as yet unclassified' }
WAAddSeasideLazyTranslatedToStrings >> initializeRewriteRule [
	self rewriteRule
		replace: '`@object '
		with: '`@object seasideLazyTranslated'
		when: [ :node | self shouldNodeBeTransformed: node ]
]

{ #category : #'as yet unclassified' }
WAAddSeasideLazyTranslatedToStrings >> name [
	^ 'add seasideLazyTranslated to non rendering objects'
]

{ #category : #'as yet unclassified' }
WAAddSeasideLazyTranslatedToStrings >> rationale [
	^ 'When outside of a request, need to use #seasideLazyTranslated.  This version is coarse, hitting every literal string outside of the WAPainter subclasses.'
]

{ #category : #'as yet unclassified' }
WAAddSeasideLazyTranslatedToStrings >> shouldNodeBeTransformed: node [

	^ self classIsNotWAPainterSubclass
		and: [ (self nodeIsInterestingString: node) and: [ 	 self parentsDoNotSendMethodToIgnore: node ] ]
]
