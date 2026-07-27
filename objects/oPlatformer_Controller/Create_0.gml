global.Platformer_Lives = 3;
global.Platformer_Level = 1;
global.Platformer_Global_Score = 0;
global.Platformer_Level_Score = 0;
global.Platformer_Global_Time = 0;

level_weird = false;

global.Platformer_Level_Time = 240; 

global.Platformer_Global_Stars = 14;
global.Platformer_Level_Stars = 0;
global.Platformer_Can_Move = false;

state = "menu";
fase_introduccion = 0;
star_index = irandom(2);

alarm[0] = game_get_speed(gamespeed_fps) * 1.5;


alarm[1] = -1; 

var _camara_inicio = view_camera[0];
camera_set_view_size(_camara_inicio, 329, 240);

musica_iniciada = false;
audio_actual = noone;
