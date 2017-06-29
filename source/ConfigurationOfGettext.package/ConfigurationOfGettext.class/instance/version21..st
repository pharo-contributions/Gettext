versions
version21: spec
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