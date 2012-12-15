as yet unclassified
methodNameFragmentsToIgnore
	"if you use things like tableClass: or divId as messages for CSS or JS or whatever add some regexes here to check for them'"

	^ #('\w+Id\:?' '\w+Class\:?' '\w+Span\:?' '\w+Width\:?' '\w+Offset\:?' '\w+Fragment\:?' 'test\w+\:?' 'log\w+\:?' 'fuel\w+\:?' 'tropo\w+\:?' 'stripe\w+\:?' '\w+[cC][sS][sS]\w+' '\w+[jJ][sS]\w+' '\w+[Uu]rl\w+\:?')