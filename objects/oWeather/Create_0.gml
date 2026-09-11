global.Wind = 0.5;
alarm = game_get_speed(gamespeed_fps) * 10;

rain_instance = undefined;
flash_alpha = 0;
index = 0;
next_minute_event = 396;
aply = false; 



global.CURRENT_WEATHER = global.WEATHER[index];

last_indoors_state = global.Is_Indoors; 