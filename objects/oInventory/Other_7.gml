if(sprite_index == sprFade){
	with(all){
		instance_destroy();
	}
	audio_stop_all();
	room_goto(rm_title);
}