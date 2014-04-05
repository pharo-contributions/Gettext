versions
version16: spec
	<version: '1.6' imports: #('1.2-baseline')>
	spec
		for: #squeakCommon
		do: [ 
			spec blessing: #development.
			spec description: 'Remove unecessary messages to translate'.
			spec author: 'Hilaire Fernandes'.
			spec timestamp: '5/4/2014 21:32'.
			spec
				package: 'Gettext' with: 'Gettext-HilaireFernandes.33' ].

	spec 
		for: #gemstone 
		do: [ 
			spec package: 'Gettext-GemStone' with: 'Gettext-GemStone-JohanBrichau.2' ]