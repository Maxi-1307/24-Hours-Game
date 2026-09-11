if(file_exists("save_data.json")){
	if (file_exists("save_data.json")) {
	    global.WEATHER = Read_Json("save_data.json").weather;
	}

	if (!variable_global_exists("WEATHER") || array_length(global.WEATHER) == 0) {
	    global.WEATHER = ["normal"];
	}	
}