Class {
	#name : #ConfigurationOfGettext,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : 'ConfigurationOfGettext'
}

{ #category : #'development support' }
ConfigurationOfGettext class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>

]

{ #category : #private }
ConfigurationOfGettext class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #MetacelloBaseConfiguration ifAbsent: aBlock ].

]

{ #category : #catalog }
ConfigurationOfGettext class >> catalogContactInfo [
	^ 'Send a mail to pharo-users@lists.pharo.org'
]

{ #category : #catalog }
ConfigurationOfGettext class >> catalogDescription [
	^ 'Gettext is an implementaion of https://www.gnu.org/software/gettext, the standard l17n package.'
]

{ #category : #catalog }
ConfigurationOfGettext class >> catalogKeywords [
	^ #(gettext localization l10n internationalization i18n)
]

{ #category : #private }
ConfigurationOfGettext class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfGettext class >> ensureMetacelloBaseConfiguration [

	Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			| repository version |
			repository := MCHttpRepository location: 'http://seaside.gemstone.com/ss/metacello' user: '' password: ''.
			repository
				versionReaderForFileNamed: 'Metacello-Base-DaleHenrichs.2.mcz'
				do: [ :reader | 
					version := reader version.
					version load.
					version workingCopy repositoryGroup addRepository: repository ] ]
]

{ #category : #'metacello tool support' }
ConfigurationOfGettext class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfGettext class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfGettext class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfGettext class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfGettext class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfGettext class >> validate [
	"Check the configuration for Errors, Critical Warnings, and Warnings (see class comment for MetacelloMCVersionValidator for more information). 
	Errors identify specification issues that will result in unexpected behaviour when you load the configuration. 
	Critical Warnings identify specification issues that may result in unexpected behavior when you load the configuration.
	Warnings identify specification issues that are technically correct, but are worth take a look at."

	"self validate"

	<apiDocumentation>
	self ensureMetacello.
	^ ((Smalltalk at: #MetacelloToolBox) validateConfiguration: self debug: #() recurse: false) explore
]

{ #category : #baselines }
ConfigurationOfGettext >> baseline10: spec [
	<version: '1.0-baseline'>
	spec
		for: #squeakCommon
		do: [ 
			spec blessing: #baseline.
			spec repository: 'http://smalltalkhub.com/mc/PharoExtras/Gettext/main'.
			spec
				project: 'Seaside3'
				with: [ 
					spec
						className: 'ConfigurationOfSeaside3';
						repository: 'http://www.smalltalkhub.com/mc/Seaside/MetacelloConfigurations/main' ].
			spec
				package: 'Gettext';
				package: 'Seaside-Gettext-Core'
					with: [ 
							spec
								repository: 'http://www.squeaksource.com/Seaside30Addons';
								requires: #('Gettext' 'Seaside3') ];
				package: 'Seaside-Gettext-Examples'
					with: [ 
							spec
								repository: 'http://www.squeaksource.com/Seaside30Addons';
								requires: #('Seaside-Gettext-Core') ].
			spec
				group: 'default' with: #('Core');
				group: 'Core' with: #('Gettext');
				group: 'GettextSeaside' with: #('Seaside-Gettext-Core');
				group: 'GettextExamples' with: #('GettextSeaside' 'Seaside-Gettext-Examples') ].
	spec
		for: #(#squeak #'pharo1.x')
		do: [ 
			spec
				project: 'RefactoringBrowser'
					with: [ 
							spec
								className: 'ConfigurationOfRefactoringBrowser';
								repository: 'http://www.squeaksource.com/MetacelloRepository' ];
				project: 'Grease'
					with: [ 
							spec
								className: 'ConfigurationOfGrease';
								loads: #('Slime');
								repository: 'http://www.squeaksource.com/MetacelloRepository' ];
				package: 'Seaside-Gettext-Slime'
					with: [ 
							spec
								repository: 'http://www.squeaksource.com/Seaside30Addons';
								requires: #('Seaside-Gettext-Core' 'RefactoringBrowser' 'Grease') ].
			spec group: 'GettextSlime' with: #('GettextSeaside' 'Seaside-Gettext-Slime') ].
	spec
		for: #pharo
		do: [ 
			spec package: 'Seaside-Pharo-Gettext-Core' with: [ spec repository: 'http://www.squeaksource.com/Seaside30Addons' ].
			spec group: 'GettextSeaside' with: #('Seaside-Pharo-Gettext-Core') ]
]

{ #category : #baselines }
ConfigurationOfGettext >> baseline11: spec [
	<version: '1.1-baseline'>
	spec
		for: #squeakCommon
		do: [ 
			spec blessing: #baseline.
			spec repository: 'http://smalltalkhub.com/mc/PharoExtras/Gettext/main'.
			spec
				project: 'Seaside3'
				with: [ 
					spec
						loads: #('Base');
						className: 'ConfigurationOfSeaside3';
						repository: 'http://www.smalltalkhub.com/mc/Seaside/MetacelloConfigurations/main' ].
			spec
				package: 'Gettext';
				package: 'Seaside-Gettext-Core'
					with: [ 
							spec
								repository: 'http://www.squeaksource.com/Seaside30Addons';
								requires: #('Gettext' 'Seaside3') ];
				package: 'Seaside-Gettext-Examples'
					with: [ 
							spec
								repository: 'http://www.squeaksource.com/Seaside30Addons';
								requires: #('Seaside-Gettext-Core') ].
			spec
				group: 'default' with: #('Core');
				group: 'Core' with: #('Gettext');
				group: 'GettextSeaside' with: #('Seaside-Gettext-Core');
				group: 'GettextExamples' with: #('GettextSeaside' 'Seaside-Gettext-Examples') ].
	spec
		for: #(#squeak #'pharo1.x')
		do: [ 
			spec
				project: 'RefactoringBrowser'
					with: [ 
							spec
								className: 'ConfigurationOfRefactoringBrowser';
								repository: 'http://www.squeaksource.com/MetacelloRepository' ];
				project: 'Grease'
					with: [ 
							spec
								className: 'ConfigurationOfGrease';
								loads: #('Slime');
								repository: 'http://www.squeaksource.com/MetacelloRepository' ];
				package: 'Seaside-Gettext-Slime'
					with: [ 
							spec
								repository: 'http://www.squeaksource.com/Seaside30Addons';
								requires: #('Seaside-Gettext-Core' 'RefactoringBrowser' 'Grease') ].
			spec group: 'GettextSlime' with: #('GettextSeaside' 'Seaside-Gettext-Slime') ].
	spec
		for: #pharo
		do: [ 
			spec package: 'Seaside-Pharo-Gettext-Core' with: [ spec repository: 'http://www.squeaksource.com/Seaside30Addons' ].
			spec group: 'GettextSeaside' with: #('Seaside-Pharo-Gettext-Core') ].
	spec
		for: #gemstone
		do: [ 
			spec package: 'Gettext' with: [ spec repository: 'http://seaside.gemtalksystems.com/ss/PharoCompat/' ].
			spec
				group: 'default' with: #('Core');
				group: 'Core' with: #('Gettext') ]
]

{ #category : #baselines }
ConfigurationOfGettext >> baseline12: spec [
	<version: '1.2-baseline'>
	spec
		for: #squeakCommon
		do: [ 
			spec blessing: #baseline.
			spec repository: 'http://smalltalkhub.com/mc/PharoExtras/Gettext/main'.
			spec
				package: 'Gettext'.
			spec
				group: 'default' with: #('Gettext')].

	spec
		for: #gemstone
		do: [ 
			spec blessing: #baseline.
			spec repository: 'http://seaside.gemtalksystems.com/ss/PharoCompat/'.
			
			spec 
				package: 'Gettext-Gemstone'.
			spec
				group: 'default' with: #('Gettext-GemStone')]
]

{ #category : #baselines }
ConfigurationOfGettext >> baseline20: spec [
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
]

{ #category : #baselines }
ConfigurationOfGettext >> baseline21: spec [
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
		for: #(#'pharo5.x' #'pharo6.x' #'pharo7.x')
		do: [ 		
			spec
				project: 'Grease Core'
					with: [ 
							spec
								className: 'ConfigurationOfGrease';
								versionString: #stable;
								loads: #('Core');
								repository: 'http://www.smalltalkhub.com/mc/Seaside/MetacelloConfigurations/main' ];
				package: 'Gettext-Core'
				with: [  spec requires: #('Grease Core') ]					
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
]

{ #category : #'symbolic versions' }
ConfigurationOfGettext >> bleedingEdge: spec [
	<symbolicVersion: #bleedingEdge>
	spec for: #common version: '2.0-baseline'
]

{ #category : #'creation-scripts' }
ConfigurationOfGettext >> createBaseline [
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
]

{ #category : #'creation-scripts' }
ConfigurationOfGettext >> createVersion [
	MetacelloToolBox
		createDevelopment: '1.0'
		for: 'Gettext'
		importFromBaseline: '1.0-baseline'
		description: 'initial development version'
]

{ #category : #accessing }
ConfigurationOfGettext >> customProjectAttributes [
	 "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes"

	^ #().
]

{ #category : #'symbolic versions' }
ConfigurationOfGettext >> development: spec [
	<symbolicVersion: #development>
	spec for: #common version: '2.0'
]

{ #category : #accessing }
ConfigurationOfGettext >> project [

	^ project ifNil: [ | constructor |
		"Bootstrap Metacello if it is not already loaded"
		(self class baseConfigurationClassIfAbsent: []) ensureMetacello.
		"Construct Metacello project"
		project := MetacelloMCProject new projectAttributes: self customProjectAttributes. 
		constructor := (Smalltalk at: #MetacelloVersionConstructor) on: self project: project.
		project loadType: #linear. "change to #atomic if desired"
		project ]
]

{ #category : #'symbolic versions' }
ConfigurationOfGettext >> stable: spec [
  	<symbolicVersion: #'stable'>
  	
	spec for: #'squeakCommon' version: '1.2'.
  	spec for: #'pharo2.x' version: '1.3.1'.
  	spec for: #'gemstone' version: '1.6.1'.
  	spec for: #'pharo3.x' version: '1.6'.
  	spec for: #'pharo4.x' version: '1.6'.
  	spec for: #'pharo5.x' version: '2.1'.
	spec for: #'pharo6.x' version: '2.1'.
	spec for: #'pharo7.x' version: '2.1'
]

{ #category : #'creation-scripts' }
ConfigurationOfGettext >> updateMetacelloToPreview [
	Gofer new
		gemsource: 'metacello';
		package: 'ConfigurationOfMetacello';
		load.	"Bootstrap Metacello 1.0-beta.32, using mcz files"
	((Smalltalk at: #ConfigurationOfMetacello) project version: '1.0-beta.32') load.	"Load the Preview version of Metacello from GitHub"
	(Smalltalk at: #Metacello) new
		configuration: 'MetacelloPreview';
		version: #stable;
		repository: 'github://dalehenrich/metacello-work:configuration';
		load
]

{ #category : #'creation-scripts' }
ConfigurationOfGettext >> validateConfiguration [
	MetacelloToolBox validateConfiguration: ConfigurationOfGettext
]

{ #category : #versions }
ConfigurationOfGettext >> version10: spec [
	<version: '1.0' imports: #('1.0-baseline')>
	spec
		for: #squeakCommon
		do: [ 
			spec blessing: #release.
			spec description: ''.
			spec author: 'PaulDeBruicker'.
			spec timestamp: '12/13/2012 15:10'.
			spec project: 'Seaside3' with: '3.0.7'.
			spec
				package: 'Gettext' with: 'Gettext-HilaireFernandes.21';
				package: 'Seaside-Gettext-Core' with: 'Seaside-Gettext-Core-WillemVanDenEnde.11';
				package: 'Seaside-Gettext-Examples' with: 'Seaside-Gettext-Examples-pmm.5' ].
	spec
		for: #(#squeak #'pharo1.x')
		do: [ 
			spec
				project: 'RefactoringBrowser' with: #stable;
				project: 'Grease' with: '1.0.8'.
			spec package: 'Seaside-Gettext-Slime' with: 'Seaside-Gettext-Slime-PaulDeBruicker.9' ].
	spec for: #pharo do: [ spec package: 'Seaside-Pharo-Gettext-Core' with: 'Seaside-Pharo-Gettext-Core-pmm.2' ]
]

{ #category : #versions }
ConfigurationOfGettext >> version11: spec [
	<version: '1.1' imports: #('1.0-baseline')>
	spec
		for: #squeakCommon
		do: [ 
			spec blessing: #release.
			spec description: ''.
			spec author: 'PaulDeBruicker'.
			spec timestamp: '12/13/2012 15:10'.
			spec project: 'Seaside3' with: '3.0.7'.
			spec
				package: 'Gettext' with: 'Gettext-HilaireFernandes.23';
				package: 'Seaside-Gettext-Core' with: 'Seaside-Gettext-Core-WillemVanDenEnde.11';
				package: 'Seaside-Gettext-Examples' with: 'Seaside-Gettext-Examples-pmm.5' ].
	spec
		for: #(#squeak #'pharo1.x')
		do: [ 
			spec
				project: 'RefactoringBrowser' with: #stable;
				project: 'Grease' with: '1.0.8'.
			spec package: 'Seaside-Gettext-Slime' with: 'Seaside-Gettext-Slime-PaulDeBruicker.9' ].
	spec for: #pharo do: [ spec package: 'Seaside-Pharo-Gettext-Core' with: 'Seaside-Pharo-Gettext-Core-pmm.2' ]
]

{ #category : #versions }
ConfigurationOfGettext >> version12: spec [
	<version: '1.2' imports: #('1.0-baseline')>
	spec
		for: #squeakCommon
		do: [ 
			spec blessing: #release.
			spec description: ''.
			spec author: 'UsmanBhatti'.
			spec timestamp: '2013-06-27T13:03:24.49+02:00'.
			spec project: 'Seaside3' with: '3.0.7'.
			spec
				package: 'Gettext' with: 'Gettext-sebastiansastre.28';
				package: 'Seaside-Gettext-Core' with: 'Seaside-Gettext-Core-WillemVanDenEnde.11';
				package: 'Seaside-Gettext-Examples' with: 'Seaside-Gettext-Examples-pmm.5' ].
	spec
		for: #(#squeak #'pharo1.x')
		do: [ 
			spec
				project: 'RefactoringBrowser' with: #stable;
				project: 'Grease' with: '1.0.8'.
			spec package: 'Seaside-Gettext-Slime' with: 'Seaside-Gettext-Slime-PaulDeBruicker.9' ].
	spec for: #pharo do: [ spec package: 'Seaside-Pharo-Gettext-Core' with: 'Seaside-Pharo-Gettext-Core-pmm.2' ]
]

{ #category : #versions }
ConfigurationOfGettext >> version131: spec [
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
]

{ #category : #versions }
ConfigurationOfGettext >> version13: spec [
	<version: '1.3' imports: #('1.1-baseline')>
	spec
		for: #squeakCommon
		do: [ 
			spec blessing: #release.
			spec description: ''.
			spec author: 'PaulDeBruicker'.
			spec timestamp: '10/5/2013 09:32'.
			spec project: 'Seaside3' with: '3.0.8'.
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
]

{ #category : #versions }
ConfigurationOfGettext >> version14: spec [
	<version: '1.4' imports: #('1.2-baseline')>
	spec
		for: #squeakCommon
		do: [ 
			spec blessing: #development.
			spec description: 'Removed Seaside & fixes for Pharo3.0'.
			spec author: 'JohanBrichau'.
			spec timestamp: '2/7/2013 17:33'.
			spec
				package: 'Gettext' with: 'Gettext-JohanBrichau.30' ].

	spec 
		for: #gemstone 
		do: [ 
			spec package: 'Gettext-GemStone' with: 'Gettext-GemStone-JohanBrichau.2' ]
]

{ #category : #versions }
ConfigurationOfGettext >> version15: spec [
	<version: '1.5' imports: #('1.2-baseline')>
	spec
		for: #squeakCommon
		do: [ 
			spec blessing: #development.
			spec description: 'fixes for Pharo3.0'.
			spec author: 'JohanBrichau'.
			spec timestamp: '3/1/2013 15:05'.
			spec
				package: 'Gettext' with: 'Gettext-JohanBrichau.32' ].

	spec 
		for: #gemstone 
		do: [ 
			spec package: 'Gettext-GemStone' with: 'Gettext-GemStone-JohanBrichau.2' ]
]

{ #category : #versions }
ConfigurationOfGettext >> version161: spec [
  <version: '1.6.1' imports: #('1.2-baseline')>
  spec
    for: #'squeakCommon'
    do: [ 
      spec blessing: #'development'.
      spec
        description:
          'Fix (GemStone) Seaside Issue #56 (https://github.com/GsDevKit/Seaside31/issues/56) sent but not implemented problems'.
      spec author: 'Dale Henrichs'.
      spec timestamp: '6/5/2015 15:27'.
      spec package: 'Gettext' with: 'Gettext-HilaireFernandes.33' ].
  spec
    for: #'gemstone'
    do: [ spec package: 'Gettext-GemStone' with: 'Gettext-GemStone-dkh.7' ]
]

{ #category : #versions }
ConfigurationOfGettext >> version16: spec [
	<version: '1.6' imports: #('1.2-baseline')>
	spec
		for: #squeakCommon
		do: [ 
			spec blessing: #development.
			spec description: 'Remove unecessary messages to translate'.
			spec author: 'Hilaire Fernandes'.
			spec timestamp: '5/4/2014 21:32'.
			spec
				package: 'Gettext' with: 'Gettext-HilaireFernandes.33' ].

	spec 
		for: #gemstone 
		do: [ 
			spec package: 'Gettext-GemStone' with: 'Gettext-GemStone-JohanBrichau.2' ]
]

{ #category : #versions }
ConfigurationOfGettext >> version20: spec [
	<version: '2.0' imports: #('2.0-baseline')>
  spec
    for: #'squeakCommon'
    do: [ 
      spec blessing: #'development'.
      spec
        description: 'Fix for Pharo5'.
      spec author: 'Johan Brichau'.
      spec timestamp: '3/16/2016 19:41'.
      spec package: 'Gettext-Core' with: 'Gettext-Core-JohanBrichau.1' ].
  spec
	 for: #(#'pharo3.x' #'pharo4.x')
	 do: [ spec package: 'Gettext-Legacy' with: 'Gettext-Legacy-JohanBrichau.1' ].
  spec
    for: #'gemstone'
    do: [ spec package: 'Gettext-GemStone' with: 'Gettext-GemStone-dkh.7' ]
]

{ #category : #versions }
ConfigurationOfGettext >> version21: spec [
	<version: '2.1' imports: #('2.1-baseline')>
  spec
    for: #'squeakCommon'
    do: [ 
      spec blessing: #'development'.
      spec
        description: 'Fix for Pharo5+6'.
      spec author: 'Johan Brichau'.
      spec timestamp: '3/17/2016 14:34'.
      spec package: 'Gettext-Core' with: 'Gettext-Core-JohanBrichau.3' ].
  spec
	 for: #(#'pharo3.x' #'pharo4.x')
	 do: [ spec package: 'Gettext-Legacy' with: 'Gettext-Legacy-JohanBrichau.1' ]
]
