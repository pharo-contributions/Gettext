actions
reset
	"Flush remembered stuff.
	Load new translators (based on the files currently found)"
	
	super reset.
	
	self createAvailableTranslators 
	 
	