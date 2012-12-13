as yet unclassified
initializeCanvasSelectors
	| jsSelectors |
	CanvasSelectorsOfInterest := (WAHtmlCanvas selectors select: [ :each | each isKeyword ]) asSet.
	CanvasSelectorsOfInterest add: #with:.
	CanvasSelectorsOfInterest add: #title:.
	CanvasSelectorsOfInterest remove: #heading:level:.
	CanvasSelectorsToIgnore := Set new.
	#(#render: #class: #id: #style: #attributeAt:put: #level: #heading:level: #translate: #on: #for:)
		do: [ :each | CanvasSelectorsToIgnore add: each ].
	jsSelectors := ((JSObject withAllSubclasses gather: [ :each | each selectors ]) select: [ :each | each isKeyword ])
		asSet.
	jsSelectors remove: #label:.
	jsSelectors remove: #confirm:.
	jsSelectors remove: #alert:.
	jsSelectors remove: #text:.
	jsSelectors remove: #title:.
	jsSelectors remove: #with:.
	jsSelectors do: [ :each | CanvasSelectorsToIgnore add: each ]