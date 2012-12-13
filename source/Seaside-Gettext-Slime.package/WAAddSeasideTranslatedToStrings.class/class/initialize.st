as yet unclassified
initialize
	"self initialize"

	self initializeCanvasSelectors.
	MethodsToIgnore := CanvasSelectorsOfInterest , CanvasSelectorsToIgnore.
	MethodsToIgnore remove: #nextPutAll:.
	InterestingSubclasses := WAPainter allSubclasses asSet