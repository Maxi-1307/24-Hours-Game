steped = false;
function Sound_Effect(){
	if(place_meeting(x,y,oPlayer) && !audio_is_playing(sfx_puddle_step)){
		audio_play_sound(sfx_puddle_step,1,false);
		steped = true;
	}
}