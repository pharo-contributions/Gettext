versions
version14: spec
	<version: '1.4' imports: #('1.2-baseline')>
	spec
		for: #squeakCommon
		do: [ 
			spec blessing: #development.
			spec description: 'Removed Seaside & fixes for Pharo3.0'.
			spec author: 'JohanBrichau'.
			spec timestamp: '2/7/2013 17:33'.
			spec
				package: 'Gettext' with: 'Gettext-JohanBrichau.30' ].

	spec 
		for: #gemstone 
		do: [ 
			spec package: 'Gettext-GemStone' with: 'Gettext-GemStone-JohanBrichau.2' ]