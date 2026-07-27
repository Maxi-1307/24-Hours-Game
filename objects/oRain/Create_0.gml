rain_instance = part_system_create(psRain);
audio_play_sound(sfx_rain,1,true);
alarm[0] = game_get_speed(gamespeed_fps) * irandom_range(10, 20);
flash_alpha = 0;
alarm[1] = game_get_speed(gamespeed_fps) * 5;