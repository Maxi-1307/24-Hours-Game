intro_state = 1;
show_text = true;

alarm[1] = 60;
timer_countdown = t_countdown;
alarm[2] = game_get_speed(gamespeed_fps) * t_countdown;
