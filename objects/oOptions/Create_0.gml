window_set_size(640, 480);
window_set_cursor(cr_none);

quit_visible = false;
quit_alpha = 0;
quit_alpha_spd = 0.08;

quit_dots = 0;
quit_dots_timer = 0;
quit_dots_speed = 15;

esc_hold_time = 0;
ESC_HOLD_LIMIT = game_get_speed(gamespeed_fps) * 1;
depth = -10000;
