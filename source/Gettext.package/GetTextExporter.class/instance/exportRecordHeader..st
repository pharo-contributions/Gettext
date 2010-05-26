private
exportRecordHeader: context
	stream 
		nextPutAll: '#: ';
		nextPutAll: context;
		cr.