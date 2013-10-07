versions
version13: spec
	<version: '1.3' imports: #('1.1-baseline')>
	spec
		for: #squeakCommon
		do: [ 
			spec blessing: #release.
			spec description: ''.
			spec author: 'PaulDeBruicker'.
			spec timestamp: '10/5/2013 09:32'.
			spec project: 'Seaside30' with: '3.0.8'.
			spec
				package: 'Gettext' with: 'Gettext-usmanbhatti.29';
				package: 'Seaside-Gettext-Core' with: 'Seaside-Gettext-Core-WillemVanDenEnde.11';
				package: 'Seaside-Gettext-Examples' with: 'Seaside-Gettext-Examples-pmm.5' ].
	spec
		for: #(#squeak #'pharo1.x')
		do: [ 
			spec
				project: 'RefactoringBrowser' with: #stable;
				project: 'Grease' with: '1.0.8'.
			spec package: 'Seaside-Gettext-Slime' with: 'Seaside-Gettext-Slime-PaulDeBruicker.9' ].
	spec for: #pharo do: [ spec package: 'Seaside-Pharo-Gettext-Core' with: 'Seaside-Pharo-Gettext-Core-pmm.2' ].
	spec for: #gemstone do: [ spec package: 'Gettext' with: 'Gettext-GemStone-JohanBrichau.2' ]