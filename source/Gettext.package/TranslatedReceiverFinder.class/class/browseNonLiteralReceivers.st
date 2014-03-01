utilities
browseNonLiteralReceivers
	"TranslatedReceiverFinder browseNonLiteralReceivers"
	SystemNavigation default
		browseMessageList: (self new nonLiteralReceiversOf: #translated)  asSortedCollection
		name: 'Non literal receivers of #translated'
		autoSelect: 'translated'