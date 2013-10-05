creation-scripts
createBaseline
	MetacelloToolBox
		createBaseline: '1.0-baseline'
		for: 'Gettext'
		repository: 'http://squeaksource.com/PharoNonCorePackages'
		requiredProjects: #('RefactoringBrowser' 'Seaside30')
		packages:
			#('Gettext' 'Seaside-Gettext-Core' 'Seaside-Gettext-Examples' 'Seaside-Gettext-Slime' 'Seaside-Pharo-Gettext-Core')
		dependencies:
			{('Seaside-Gettext-Core' -> #('Gettext' 'Seaside30')).
			('Seaside-Gettext-Slime' -> #('Seaside-Gettext-Core' 'RefactoringBrowser')).
			('Seaside-Gettext-Examples' -> #(#Seaside #- #Gettext #- #Core))}
		groups:
			{('Core' -> #('Gettext')).
			('Seaside' -> #('Seaside-Gettext-Core')).
			('Slime' -> #('Seaside-Gettext-Slime')).
			('Examples' -> #('Seaside-Gettext-Examples'))}	"Project name"