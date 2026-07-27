if (intro_state == 2 && timer_sound_only > 0) {
    audio_play_sound(sfx_menu_move, 1, false); 
    timer_sound_only -= 1;
    alarm[3] = 60;
}
