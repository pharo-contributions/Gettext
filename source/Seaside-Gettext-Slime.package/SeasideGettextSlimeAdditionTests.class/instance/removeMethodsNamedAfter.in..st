as yet unclassified
removeMethodsNamedAfter: aMethodSelector in: class
	class removeMethod: ('render' , aMethodSelector allButLast capitalized , 'Hi:') asSymbol.
	class removeMethod:('render' , aMethodSelector allButLast capitalized , 'HeyYou:') asSymbol.
	class removeMethod: ('render' , aMethodSelector allButLast capitalized , 'HeyYouTwo:') asSymbol