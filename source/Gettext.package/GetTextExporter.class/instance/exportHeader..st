private
exportHeader: domainName
	| headers |
	self exportTag: 'msgid' msg: ''.
	self exportTag: 'msgstr' msg: ''.
	headers := self createHeaders.
	headers add: 'X-Pharo-Domain' -> domainName.
	headers do: [:each | self exportHeaderLineKey: each key value: each value].
	stream cr; cr