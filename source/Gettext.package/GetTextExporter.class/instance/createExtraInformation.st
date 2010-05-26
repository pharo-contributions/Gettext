private
createExtraInformation
	| extras |
	extras := OrderedCollection new.
	#(
		'Language name as you''d like it to appear in the Languages menu' 'Language-Name'
		'Scale to apply to font size (2 for twice as large)' 'Font-Scale'
		'Directionality of language' 'Language-Direction'
		'Use this if you do not want any of the text to be bolded, for legibility' 'Suppress-Bold'
		'Font to use on a Windows system' 'Win-Font'
		'Font to use on a Mac system' 'Mac-Font'
		'Font to use on a Linux system' 'Linux-Font') pairsDo: [:first :second |
			extras add: (Array with: '' with: first with: second).
	].
	^ extras