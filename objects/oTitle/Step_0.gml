audio_group_set_gain(audiogroupVolume, global.Master_Volume / 100, 0);
audio_group_set_gain(audiogroupVolumeSFX, global.SFX_Volume / 100, 0);

if (menu_state == 0) {
    if (keyboard_check_pressed(global.DownKey) && selection < 2) {
        selection++;
        audio_play_sound(sfx_menu_move, 1, false);
    }

    if (keyboard_check_pressed(global.UpKey) && selection > 0) {
        selection--;
        audio_play_sound(sfx_menu_move, 1, false);
    }

    if (keyboard_check_pressed(global.ConfirmKey)) {
        audio_play_sound(sfx_select, 1, false);
        switch (selection) {
            case 0: menu_state = 5; sprite_index = sprFade; image_speed = 0.5; break;
            case 1: menu_state = 1; break;
            case 2: game_end(); break;
        }
    }
    if (keyboard_check_pressed(global.CancelKey) && !keyboard_check_pressed(global.ConfirmKey) && selection == 0) {
        file_delete("save_data.json");
        audio_play_sound(sfx_select, 1, false);
    }

    menu_y_offset = lerp(menu_y_offset, 0, 0.03);
}

if (menu_state == 1) {
    menu_x_offset = lerp(menu_x_offset, -600, 0.04);
    if (menu_x_offset < -550) {
        menu_state = 2;
    }
}

if (menu_state == 2) {
    var max_options = 5;

    if (!settings_editing) {
        if (keyboard_check_pressed(global.DownKey)) {
            settings_index++;
            audio_play_sound(sfx_menu_move, 1, false);
            if (settings_index > max_options) settings_index = 0;
        }

        if (keyboard_check_pressed(global.UpKey)) {
            settings_index--;
            audio_play_sound(sfx_menu_move, 1, false);
            if (settings_index < 0) settings_index = max_options;
        }
        
        if (keyboard_check_pressed(global.CancelKey)) {
            show_debug_message("Animacion de vuelta al menu");
            menu_state = 4;
            settings_index = 0;
            settings_editing = false;
            audio_play_sound(sfx_select, 1, false);
            exit;
        }
        
        if (keyboard_check_pressed(global.ConfirmKey)) {
            audio_play_sound(sfx_select, 1, false);
            if (settings_index == 3) {
                menu_state = 3;
                controls_index = 0;
                listening_key = false;
                keyboard_lastkey = 0;
                block_input = true;
                settings_editing = false;
            } else {
                settings_editing = true;
                key_hold_timer = 0;
            }
            exit;
        }
    } 
    else {
        var step = 5;
        key_hold_timer++;

        function hold(k) {
            return keyboard_check(k);
        }

        function repeat_ok() {
            return (key_hold_timer == 1 || key_hold_timer > key_repeat_delay);
        }

        if (!hold(global.UpKey) && !hold(global.DownKey) && !hold(global.LeftKey) && !hold(global.RightKey) &&
            !hold(vk_up) && !hold(vk_down) && !hold(vk_left) && !hold(vk_right)) {
            key_hold_timer = 0;
        }

        // Master Volume
        if (settings_index == 0) {
            if (repeat_ok()) {
                if (hold(global.RightKey) || hold(global.UpKey) || hold(vk_right) || hold(vk_up)) {
                    audio_play_sound(sfx_menu_move, 1, false);
                    global.Master_Volume = min(global.Master_Volume + step, 100);
                    key_hold_timer = 2;
                }
                if (hold(global.LeftKey) || hold(global.DownKey) || hold(vk_left) || hold(vk_down)) {
                    audio_play_sound(sfx_menu_move, 1, false);
                    global.Master_Volume = max(global.Master_Volume - step, 0);
                    key_hold_timer = 2;
                }
            }
        }

        // SFX Volume
        if (settings_index == 1) {
            if (repeat_ok()) {
                if (hold(global.RightKey) || hold(global.UpKey) || hold(vk_right) || hold(vk_up)) {
                    audio_play_sound(sfx_menu_move, 1, false);
                    global.SFX_Volume = min(global.SFX_Volume + step, 100);
                    key_hold_timer = 2;
                }
                if (hold(global.LeftKey) || hold(global.DownKey) || hold(vk_left) || hold(vk_down)) {
                    audio_play_sound(sfx_menu_move, 1, false);
                    global.SFX_Volume = max(global.SFX_Volume - step, 0);
                    key_hold_timer = 2;
                }
            }
        }

        //Simplify VFX
        if (settings_index == 2) {
            if (keyboard_check_pressed(vk_right) || keyboard_check_pressed(vk_up) || keyboard_check_pressed(global.RightKey) || keyboard_check_pressed(global.UpKey) ||
                keyboard_check_pressed(vk_left) || keyboard_check_pressed(vk_down) || keyboard_check_pressed(global.LeftKey) || keyboard_check_pressed(global.DownKey)) {
                audio_play_sound(sfx_menu_move, 1, false);
                global.SimplifyVFX = (global.SimplifyVFX == 0) ? 1 : 0;
            }
        }

        // Language
        if (settings_index == 4) {
            if (keyboard_check_pressed(vk_right) || keyboard_check_pressed(vk_up) || keyboard_check_pressed(global.RightKey) || keyboard_check_pressed(global.UpKey)) {
                audio_play_sound(sfx_menu_move, 1, false);
                global.Language = (global.Language + 1) mod array_length(lang);
                if (global.Language == 0) cargar_idioma("es");
                if (global.Language == 1) cargar_idioma("en");
            }
            if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(vk_down) || keyboard_check_pressed(global.LeftKey) || keyboard_check_pressed(global.DownKey)) {
                audio_play_sound(sfx_menu_move, 1, false);
                global.Language = (global.Language - 1 + array_length(lang)) mod array_length(lang);
                if (global.Language == 0) cargar_idioma("es");
                if (global.Language == 1) cargar_idioma("en");
            }
        }
if (settings_index == 5) {
    if (keyboard_check_pressed(global.ConfirmKey)) {
        audio_play_sound(sfx_menu_move, 1, false);
        global.BordersEnabled = !global.BordersEnabled;
    }

    if (keyboard_check_pressed(global.CancelKey)) {
        audio_play_sound(sfx_select, 1, false);
        settings_editing = false;
        key_hold_timer = 0;
        keyboard_clear(global.CancelKey);
        exit;
    }
}


        if (keyboard_check_pressed(global.CancelKey)) {
            audio_play_sound(sfx_select, 1, false);
            settings_editing = false;
            key_hold_timer = 0;
            keyboard_clear(global.CancelKey);
            exit;
        }
    }
}

if (menu_state == 3) {
    if (block_input) {
        if (!keyboard_check(global.ConfirmKey)) {
            audio_play_sound(sfx_select, 1, false);
            block_input = false;
        }
        exit;
    }

    if (!listening_key) {
        if (keyboard_check_pressed(global.DownKey) && controls_index < 8) {
            controls_index++;
            audio_play_sound(sfx_menu_move, 1, false);
        }
        if (keyboard_check_pressed(global.UpKey) && controls_index > 0) {
            controls_index--;
            audio_play_sound(sfx_menu_move, 1, false);
        }
        if (keyboard_check_pressed(global.CancelKey)) {
            menu_state = 2;
            settings_index = 0;
            settings_editing = false;
            audio_play_sound(sfx_select, 1, false);
            exit;
        }
        if (keyboard_check_pressed(global.ConfirmKey)) {
            audio_play_sound(sfx_select, 1, false);
            if (controls_index < 7) {
                listening_key = true;
                keyboard_lastkey = 0;
            }
            if (controls_index == 7) {
                global.DownKey = vk_down;
                global.UpKey = vk_up;
                global.LeftKey = vk_left;
                global.RightKey = vk_right;
                global.ConfirmKey = ord("Z");
                global.CancelKey = ord("X");
                global.MenuKey = ord("C");
            }
            if (controls_index == 8) {
                menu_state = 2;
                settings_index = 0;
                settings_editing = false;
            }
            exit;
        }
    }
    
    if (listening_key) {
        if (keyboard_check_pressed(global.CancelKey)) {
            listening_key = false;
            audio_play_sound(sfx_select, 1, false);
            exit;
        }

        if (keyboard_lastkey != 0) {
            var k = keyboard_lastkey;
            var keys = [global.DownKey, global.UpKey, global.LeftKey, global.RightKey, global.ConfirmKey, global.CancelKey, global.MenuKey];
            var swap_index = -1;
            for (var i = 0; i < 7; i++) {
                if (keys[i] == k) {
                    swap_index = i;
                    break;
                }
            }
            if (swap_index != -1) {
                var temp = keys[controls_index];
                keys[controls_index] = keys[swap_index];
                keys[swap_index] = temp;
            } else {
                keys[controls_index] = k;
            }
            global.DownKey = keys[0];
            global.UpKey = keys[1];
            global.LeftKey = keys[2];
            global.RightKey = keys[3];
            global.ConfirmKey = keys[4];
            global.CancelKey = keys[5];
            global.MenuKey = keys[6];
            listening_key = false;
            exit;
        }
    }
}

if (menu_state == 4) {
    settings_x_offset = lerp(settings_x_offset, 800, 0.04);
    menu_x_offset = lerp(menu_x_offset, 0, 0.04);
    
    if (menu_x_offset > -10) {
        menu_x_offset = 0;
        settings_x_offset = 0; 
        menu_state = 0;
		SaveSettings();
    }
}