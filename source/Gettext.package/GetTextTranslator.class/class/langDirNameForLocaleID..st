private
langDirNameForLocaleID: id
	"returns relative path from locale directory to actual directory containing MOs"
	^(id posixName) , (FileDirectory slash)  , 'LC_MESSAGES'