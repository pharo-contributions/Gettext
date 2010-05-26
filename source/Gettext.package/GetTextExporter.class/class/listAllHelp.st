utilities
listAllHelp
	"self listAllHelp"
	| spec specs oCatalog flap flapSelectors allKeys oCatalogHelp flapHelp |
	oCatalog := Dictionary new.
	Morph withAllSubclasses
		do: [:aClass | (aClass class includesSelector: #descriptionForPartsBin)
				ifTrue: [spec := aClass descriptionForPartsBin.
					oCatalog at: spec formalName put: spec documentation]].
	Morph withAllSubclasses
		do: [:aClass | (aClass class includesSelector: #supplementaryPartsDescriptions)
				ifTrue: [specs := aClass supplementaryPartsDescriptions.
					specs
						do: [:each | oCatalog at: each formalName put: each documentation]]].
	flap := Dictionary new.
	flapSelectors := #(#defaultsQuadsDefiningPlugInSuppliesFlap #defaultsQuadsDefiningStackToolsFlap #defaultsQuadsDefiningSuppliesFlap #defaultsQuadsDefiningToolsFlap #defaultsQuadsDefiningWidgetsFlap #defaultsQuadsDefiningScriptingFlap ).
	flapSelectors
		do: [:selector | 
			specs := Flaps perform: selector.
			specs
				do: [:each | flap at: each third put: each fourth]].
	allKeys := oCatalog keys intersection: flap keys.
	allKeys asArray sort
		do: [:each | 
			oCatalogHelp := oCatalog
						at: each
						ifAbsent: [''].
			flapHelp := flap
						at: each
						ifAbsent: [''].
			oCatalogHelp = flapHelp
				ifFalse: [Transcript cr; show: 'Name: ' , each.
					Transcript cr; show: 'O: ' , oCatalogHelp.
					Transcript cr; show: 'F: ' , flapHelp.
					Transcript cr.

]]