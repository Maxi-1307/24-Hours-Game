if (!global.Is_Indoors) {
    
    var _snd = choose(sfx_thunder_left, sfx_thunder_right); 
    
    var _thunder_inst = audio_play_sound(_snd, 10, false);
    

    flash_alpha = 0.4; 
}

alarm[0] = game_get_speed(gamespeed_fps) * irandom_range(10, 25);
