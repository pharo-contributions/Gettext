accessing
defaultSelectors
	"Answers the selectors that are sent to strings that should be translated"
	
	^ #(
		#translated 
		#translatedInDomain:
		#translatedInDomain:locale:
		#translatedNoop
		)