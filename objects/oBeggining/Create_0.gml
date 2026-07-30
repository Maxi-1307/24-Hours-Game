var time_black_initial = 5;
var time_countdown     = 10;
var time_sound_only    = 10;

center_x = 160;
center_y = 120;

hours = 24;
minutes = 0;
seconds = 0;

intro_state = 0;    
show_text = false;  
fade_alpha = 0;

alarm[0] = game_get_speed(gamespeed_fps) * time_black_initial; 

t_countdown = time_countdown;
t_sound_only = time_sound_only;


if (!file_exists("save_data.json")) {global.WEATHER = []; global.TURNS = [];}
index = 0