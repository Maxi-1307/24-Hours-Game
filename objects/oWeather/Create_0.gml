global.Wind = 0.5;
alarm = game_get_speed(gamespeed_fps) * 10;

rain_instance = undefined;
flash_alpha = 0;
index = 0;
next_minute_event = 396;
aply = false; 

if (file_exists("save_data.json")) {
    global.WEATHER = Read_Json("save_data.json").weather;
}

if (!variable_global_exists("WEATHER") || array_length(global.WEATHER) == 0) {
    global.WEATHER = ["normal"];
}

global.CURRENT_WEATHER = global.WEATHER[index];

last_indoors_state = global.Is_Indoors; 