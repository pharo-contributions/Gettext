private
export: literals translator: translator domain: domainName 
	| fileName |
	"Export a gettext file in a category. literals is a dictionary of keyword -> #(MethodReference...) in the textDomain."
	fileName := self dirNameDomain: domainName translator: translator.
	[stream := FileStream forceNewFileNamed: fileName.
	stream lineEndConvention: #lf.
	stream converter: UTF8TextConverter new.
	self exportHeader: domainName.
	self exportBody: literals translator: translator]
		ensure: [stream close]