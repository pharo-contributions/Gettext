baselines
baseline11: spec
	<version: '1.1-baseline'>
	spec
		for: #squeakCommon
		do: [ 
			spec blessing: #baseline.
			spec repository: 'http://smalltalkhub.com/mc/PharoExtras/Gettext/main'.
			spec
				project: 'RefactoringBrowser'
					with: [ 
							spec
								className: 'ConfigurationOfRefactoringBrowser';
								repository: 'http://www.squeaksource.com/MetacelloRepository' ];
				project: 'Seaside30'
					with: [ 
							spec
								className: 'ConfigurationOfSeaside30';
								repository: 'http://www.squeaksource.com/MetacelloRepository' ];
				project: 'Grease'
					with: [ 
							spec
								className: 'ConfigurationOfGrease';
								loads: 'Grease Slime';
								repository: 'http://www.squeaksource.com/MetacelloRepository' ].
			spec
				package: 'Gettext';
				package: 'Seaside-Gettext-Core'
					with: [ 
							spec
								repository: 'http://www.squeaksource.com/Seaside30Addons';
								requires: #('Gettext' 'Seaside30') ];
				package: 'Seaside-Gettext-Examples'
					with: [ 
							spec
								repository: 'http://www.squeaksource.com/Seaside30Addons';
								requires: #('Seaside-Gettext-Core') ];
				package: 'Seaside-Gettext-Slime'
					with: [ 
							spec
								repository: 'http://www.squeaksource.com/Seaside30Addons';
								requires: #('Seaside-Gettext-Core' 'RefactoringBrowser' 'Grease') ].
			spec
				group: 'default' with: #('Core');
				group: 'Core' with: #('Gettext');
				group: 'GettextSeaside' with: #('Seaside-Gettext-Core');
				group: 'GettextSlime' with: #('GettextSeaside' 'Seaside-Gettext-Slime');
				group: 'GettextExamples' with: #('GettextSeaside' 'Seaside-Gettext-Examples') ].
	spec
		for: #pharo
		do: [ 
			spec package: 'Seaside-Pharo-Gettext-Core' with: [ spec repository: 'http://www.squeaksource.com/Seaside30Addons' ].
			spec group: 'GettextSeaside' with: #('Seaside-Pharo-Gettext-Core') ].
	spec
		for: #gemstone
		do: [ 
			spec package: 'Gettext' with: [ spec repository: 'http://seaside.gemstone.com/ss/PharoCompat/' ].
			spec
				group: 'default' with: #('Core');
				group: 'Core' with: #('Gettext') ]