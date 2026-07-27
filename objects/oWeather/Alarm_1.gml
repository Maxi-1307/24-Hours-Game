var _snd = choose(sfx_thunder_left, sfx_thunder_right); 
var _thunder_inst = audio_play_sound(_snd, 10, false);

if (global.Is_Indoors) {
    audio_sound_gain(_thunder_inst, 0.3, 0);
    flash_alpha = 0;
} else {
    audio_sound_gain(_thunder_inst, 1.0, 0);
    flash_alpha = 0.4;
}

var _tiempo = (global.CURRENT_WEATHER == "tormentoso") ? irandom_range(5, 15) : irandom_range(10, 25);
alarm = game_get_speed(gamespeed_fps) * _tiempo;