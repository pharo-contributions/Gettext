as yet unclassified
initializeCanvasSelectors
	CanvasSelectorsOfInterest := (WAHtmlCanvas selectors select: [ :each | each isKeyword ]) asSet.
	CanvasSelectorsOfInterest add: #with:.
	CanvasSelectorsOfInterest add: #title:.
	CanvasSelectorsOfInterest remove: #heading:level:.
	CanvasSelectorsToIgnore := Set new.
	#(#render: #title: #class: #id: #style: #attributeAt:put: #level:) do: [ :each | CanvasSelectorsToIgnore add: each ]