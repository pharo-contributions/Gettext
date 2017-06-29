baselines
baseline21: spec
	<version: '2.1-baseline'>
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
		for: #(#'pharo5.x' #'pharo6.x')
		do: [ 		
			spec
				project: 'Grease Core'
					with: [ 
							spec
								className: 'ConfigurationOfGrease';
								versionString: #stable;
								loads: #('Core');
								repository: 'http://www.smalltalkhub.com/mc/Seaside/MetacelloConfigurations/main' ];
				package: 'Gettext-Legacy';
				package: 'Gettext-Core'
				with: [  spec includes: #('Gettext-Legacy'); requires: #('Grease Core') . ]					
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