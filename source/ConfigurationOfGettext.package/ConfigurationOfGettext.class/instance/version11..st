versions
version11: spec
	<version: '1.1' imports: #('1.0-baseline')>
	spec
		for: #squeakCommon
		do: [ 
			spec blessing: #release.
			spec description: ''.
			spec author: 'PaulDeBruicker'.
			spec timestamp: '12/13/2012 15:10'.
			spec
				project: 'RefactoringBrowser' with: #stable;
				project: 'Seaside30' with: '3.0.7';
				project: 'Grease' with: #stable.
			spec
				package: 'Gettext' with: 'Gettext-HilaireFernandes.23';
				package: 'Seaside-Gettext-Core' with: 'Seaside-Gettext-Core-WillemVanDenEnde.11';
				package: 'Seaside-Gettext-Examples' with: 'Seaside-Gettext-Examples-pmm.5';
				package: 'Seaside-Gettext-Slime' with: 'Seaside-Gettext-Slime-PaulDeBruicker.9' ].
	spec for: #pharo do: [ spec package: 'Seaside-Pharo-Gettext-Core' with: 'Seaside-Pharo-Gettext-Core-pmm.2' ]