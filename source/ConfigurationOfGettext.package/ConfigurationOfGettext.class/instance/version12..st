versions
version12: spec
	<version: '1.2' imports: #('1.0-baseline')>
	spec
		for: #squeakCommon
		do: [ 
			spec blessing: #release.
			spec description: ''.
			spec author: 'UsmanBhatti'.
			spec timestamp: '2013-06-27T13:03:24.49+02:00'.
			spec
				project: 'RefactoringBrowser' with: #stable;
				project: 'Seaside30' with: '3.0.7';
				project: 'Grease' with: #stable.
			spec
				package: 'Gettext' with: 'Gettext-usmanbhatti.29';
				package: 'Seaside-Gettext-Core' with: 'Seaside-Gettext-Core-WillemVanDenEnde.11';
				package: 'Seaside-Gettext-Examples' with: 'Seaside-Gettext-Examples-pmm.5';
				package: 'Seaside-Gettext-Slime' with: 'Seaside-Gettext-Slime-PaulDeBruicker.9' ].
	spec for: #pharo do: [ spec package: 'Seaside-Pharo-Gettext-Core' with: 'Seaside-Pharo-Gettext-Core-pmm.2' ]