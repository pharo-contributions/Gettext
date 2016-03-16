private
langDirNameForLocaleID: id
	"returns relative path from locale directory to actual directory containing MOs"
	^(id posixName) , (FileSystem disk delimiter asString)  , 'LC_MESSAGES'