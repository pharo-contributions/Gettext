as yet unclassified
initializeCanvasSelectors
	CanvasSelectorsOfInterest := (WAHtmlCanvas selectors select: [ :each | each isKeyword ]) asSet.
	CanvasSelectorsOfInterest add: #with:.
	CanvasSelectorsOfInterest add: #title:.
	CanvasSelectorsToIgnore := Set new.
	#(#render: #title: #class: #id: #style: #attributeAt:put: #level:) do: [ :each | CanvasSelectorsToIgnore add: each ]