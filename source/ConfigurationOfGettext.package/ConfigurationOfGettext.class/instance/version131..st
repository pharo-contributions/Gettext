versions
version131: spec
	<version: '1.3.1' imports: #('1.1-baseline')>
	spec
		for: #squeakCommon
		do: [ 
			spec blessing: #released.
			spec description: 'Identical to 1.3 but removed Seaside to load gettext clean in Pharo2.0'.
			spec author: 'JohanBrichau'.
			spec timestamp: '10/04/2014 10:25'.
			spec
				package: 'Gettext' with: 'Gettext-usmanbhatti.29'].

	spec 
		for: #gemstone 
		do: [ 
			spec package: 'Gettext-GemStone' with: 'Gettext-GemStone-JohanBrichau.2' ]