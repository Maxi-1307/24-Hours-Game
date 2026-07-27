if (keyboard_check_pressed(vk_f4)) {
    if (window_get_fullscreen()) {
        window_set_fullscreen(false);
        window_set_size(640, 480);
        surface_resize(application_surface, 640, 480);
    } else {
        window_set_fullscreen(true);
        surface_resize(application_surface, 640, 480);
    }
}

if (keyboard_check(vk_escape)) {
    quit_visible = true; 
    if (quit_alpha < 1) {
        quit_alpha = min(quit_alpha + quit_alpha_spd, 1);
    }

    quit_dots_timer++;
    if (quit_dots_timer >= quit_dots_speed) {
        quit_dots_timer = 0;
        quit_dots++;
        
        if (quit_dots > 3) {
            quit_dots = 0;
        }
    }

    esc_hold_time++;
    if (esc_hold_time >= ESC_HOLD_LIMIT) {
        game_end();
    }

} else {
    esc_hold_time = 0;
    
    if (quit_alpha > 0) {
        quit_alpha = max(quit_alpha - quit_alpha_spd, 0);
        
        if (quit_alpha <= 0) {
            quit_visible = false;
            quit_dots = 0;
            quit_dots_timer = 0;
        }
    }
}