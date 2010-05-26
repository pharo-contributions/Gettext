accessing
domainRegistered: aDomainName
	"notify that new TextDomain is registered"
	self translators do: [:each | each domainRegistered: aDomainName]