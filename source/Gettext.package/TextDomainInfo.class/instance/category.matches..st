private
category: categoryName matches: prefix
	^ categoryName notNil and: [categoryName = prefix or: [categoryName beginsWith: prefix, '-']]