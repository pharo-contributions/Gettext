private
exportInformation: anOrderedCollection
	anOrderedCollection do: [:each |
		self exportRecordHeader: each second.
		self exportPhrase: each third translation: ''].
	stream cr.