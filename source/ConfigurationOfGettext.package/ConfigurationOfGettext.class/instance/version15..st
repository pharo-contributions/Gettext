versions
version15: spec
	<version: '1.5' imports: #('1.2-baseline')>
	spec
		for: #squeakCommon
		do: [ 
			spec blessing: #development.
			spec description: 'fixes for Pharo3.0'.
			spec author: 'JohanBrichau'.
			spec timestamp: '3/1/2013 10:40'.
			spec
				package: 'Gettext' with: 'Gettext-JohanBrichau.31' ].

	spec 
		for: #gemstone 
		do: [ 
			spec package: 'Gettext-GemStone' with: 'Gettext-GemStone-JohanBrichau.2' ]