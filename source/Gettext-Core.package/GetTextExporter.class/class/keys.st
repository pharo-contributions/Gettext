utilities
keys
	| categories |
	categories := Dictionary new.
	GetTextExporter new appendTranslations: categories.
	^ categories values
		inject: Set new
		into: [:set :next | set addAll: next keys;
				 yourself]