file out
exportBody: literals translator: translator 
	"Export a gettext file body. literals is a dictionary of keyword ->
	#(MethodReference...) in the textDomain."
	"Build {sortKey. comment. msgid } to optimize sorting (getting category is
	too slow).
	If there are two or more methods for a mgsid, only first method
	(alphabetical) is used for sorting."
	| sorted msgid sortedMethods category sortKey comment triplets commentUnderLined |
	triplets := literals associations
				collect: [:assoc | 
					msgid := assoc key.
					sortedMethods := assoc value asArray sort.
					category := (Smalltalk at: sortedMethods first theNonMetaClassName) category asString.
					sortKey := category , ',' , sortedMethods first printString , ',' , msgid.
					comment := (sortedMethods
								collect: [:each | each actualClass asString , '>>' , each methodSymbol asString])
								inject: category
								into: [:result :methodName | result , ',' , methodName].
					"Replace white spaces to := because gettext tool might
					replace a space to a new line some times, and it makes
					difficult to take a diff."
					commentUnderLined := comment copyReplaceAll: ' ' with: ':='.
					Array
						with: sortKey
						with: commentUnderLined
						with: msgid].
	"Sort and output the words"
	sorted := triplets
				sort: [:a :b | a first <= b first].
	sorted
		do: [:triplet | 
			comment := triplet second.
			msgid := triplet third.
			self exportRecordHeader: comment.
			self
				exportPhrase: msgid
				translation: (self translationFor: msgid in: translator)]