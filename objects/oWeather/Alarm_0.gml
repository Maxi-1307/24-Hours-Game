if (!global.Is_Indoors) {
    if (global.Wind < 0) {
        audio_play_sound(sfxWind_Left, 1, false);
    } else if (global.Wind > 0) {
        audio_play_sound(sfxWind_Right, 1, false); 
    }
}
alarm = game_get_speed(gamespeed_fps) * 10;