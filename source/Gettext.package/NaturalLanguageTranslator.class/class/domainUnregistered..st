accessing
domainUnregistered: aDomainName
	"notify that new TextDomain is unregistered"
	self translators do: [:each | each domainUnregistered: aDomainName]