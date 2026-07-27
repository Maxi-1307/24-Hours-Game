image_speed = 1;
image_index = 0;
alpha = 1;

state = 0;
sonido_id = -1;
timer = 0;

wait_time = game_get_speed(gamespeed_fps) * 2; 

sonido_a_reproducir = sfxShower; 
oPlayer.sprite_index = sprPlayerUp;
audio_pause_all(); 
if(global.HasShowered == 0){
	global.HasShowered = 2;
}else{
	global.HasShowered += 1;
}