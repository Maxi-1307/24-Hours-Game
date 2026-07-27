sprite_index = sprMusical_Audience;

image_speed = 0.35; 
image_index = 0;

y_target = 161;
fase_publico = "subiendo";

alarm[0] = game_get_speed(gamespeed_fps) * 2.5;


audio_play_sound(sfx_Audience_Cheer, 10, false);
