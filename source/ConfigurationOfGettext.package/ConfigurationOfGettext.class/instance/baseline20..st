baselines
baseline20: spec
	<version: '2.0-baseline'>
	spec
		for: #squeakCommon
		do: [ 
			spec blessing: #baseline.
			spec repository: 'http://smalltalkhub.com/mc/PharoExtras/Gettext/main'.
			spec
				package: 'Gettext-Core'.
			spec
				group: 'default' with: #('Gettext-Core')].
			
	spec
		for: #(#'pharo3.x' #'pharo4.x')
		do: [ 		
			spec
				package: 'Gettext-Legacy';
				package: 'Gettext-Core'
				with: [  spec includes: 'Gettext-Legacy' ]					
		].

	spec
		for: #gemstone
		do: [ 
			spec blessing: #baseline.
			spec repository: 'http://seaside.gemtalksystems.com/ss/PharoCompat/'.
			
			spec 
				package: 'Gettext-Gemstone'.
			spec
				group: 'default' with: #('Gettext-GemStone')]