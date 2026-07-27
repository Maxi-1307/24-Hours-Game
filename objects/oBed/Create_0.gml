image_speed = 1;
image_index = 0;

state = 0;
timer = 0;
wait_time = game_get_speed(gamespeed_fps) * 10;
audio_pause_all();
switch(global.Bed_times_slept){
	case 0: global.game_minutes += 60;break;
	case 1: global.game_minutes += 120;break;
	default: global.game_minutes += 180;break;
}
 global.Bed_times_slept += 1;
