if(sprite_index == sprFade){
	if (file_exists("save_data.json")) {
		LoadGame();
	} else {
		 room_goto(rm_beggining);
	}
   
	instance_destroy();
}