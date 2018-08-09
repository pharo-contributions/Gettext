baselines
baseline: spec
	<baseline>
	spec
		for: #squeakCommon
		do: [ 
			spec
				package: 'Gettext-Core'.
			spec
				group: 'default' with: #('Gettext-Core')].
			
	spec
		for: #(#'pharo3.x' #'pharo4.x')
		do: [ 		
			spec
				package: 'Gettext-Legacy';
				package: 'Gettext-Core' with: [  spec includes: 'Gettext-Legacy' ]					
		].
	
	spec
		for: #(#'pharo5.x' #'pharo6.x' #'pharo7.x')
		do: [ 		
			spec
				baseline: 'Grease' with: [ 
					spec 
						repository: 'github://SeasideSt/Grease:v1.3.0/repository' ];
				
				package: 'Gettext-Core' with: [  spec requires: #('Grease') ]					
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