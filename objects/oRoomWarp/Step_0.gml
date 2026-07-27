if(place_meeting(x,y,oPlayer) && !instance_exists(oFade)){
	refresh();
	var instance = instance_create_depth(0,0,-9999,oFade);
	instance.target_x = target_x;
	instance.target_y = target_y;
	instance.target_room = target_room;
	instance.facing = facing;
	instance.is_indoors = is_indoors;
	if(audio != noone){
		audio_play_sound(audio,1,false);
	}
}