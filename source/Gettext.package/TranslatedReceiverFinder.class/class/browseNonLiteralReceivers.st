utilities
browseNonLiteralReceivers
	"TranslatedReceiverFinder browseNonLiteralReceivers"
	SystemNavigation default
		browseMessageList: self new nonLiteralReceivers  asSortedCollection
		name: 'Non literal receivers of #translated'
		autoSelect: 'translated'