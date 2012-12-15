as yet unclassified
initializeCanvasSelectors
	| jsSelectors |
	CanvasSelectorsOfInterest := (WAHtmlCanvas selectors select: [ :each | each isKeyword ]) asSet.
	CanvasSelectorsOfInterest remove: #heading:level:.
	CanvasSelectorsToIgnore := Set new.
	#(#render: #class: #id: #style: #attributeAt:put: #level: #heading:level: #translate: #on: #for: #handleRequest: #lint: #rationale: #at: #at:put: #resourceUrl: #url: #updateRoot: #updateUrl: #seasideTranslated #seasideLazyTranslated)
		do: [ :each | CanvasSelectorsToIgnore add: each ].
	jsSelectors := ((JSObject withAllSubclasses gather: [ :each | each selectors ]) select: [ :each | each isKeyword ])
		asSet.
	jsSelectors do: [ :each | CanvasSelectorsToIgnore add: each ].
	#(#with: #title: #text: #alert: #confirm: #label: #header:)
		do: [ :each | 
			CanvasSelectorsOfInterest add: each.
			CanvasSelectorsToIgnore remove: each ifAbsent: [ nil ] ]