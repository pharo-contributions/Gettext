versions
version161: spec
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