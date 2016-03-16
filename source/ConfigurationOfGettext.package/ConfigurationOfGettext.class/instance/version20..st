versions
version20: spec
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