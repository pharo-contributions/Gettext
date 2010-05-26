accessing
registerClass: className domain: aDomainName
	LoneClasses at: className put: aDomainName.
	self refresh.	"moves it to Classes"
