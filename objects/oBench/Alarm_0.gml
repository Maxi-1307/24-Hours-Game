if (player_sitting) {
    
    if (bench_frame == 1) {
        bench_frame = 2;
        oPlayer.image_index = 2;
		    alarm[0] = game_get_speed(gamespeed_fps) * 0.5;
    } else {
        bench_frame = 1;
        oPlayer.image_index = 1;
		alarm[0] = game_get_speed(gamespeed_fps) * 2;
    }
    
}