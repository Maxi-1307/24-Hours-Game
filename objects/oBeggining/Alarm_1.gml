if (intro_state == 1 && timer_countdown > 0) {
    seconds -= 1;
    timer_countdown -= 1;
    audio_play_sound(sfx_menu_move, 1, false); 
    alarm[1] = 60; 
}
