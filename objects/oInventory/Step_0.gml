global.CanMove = false;

if (menu_state == 6) {
    if (!keyboard_check(global.ConfirmKey)) {
        z_lock = false;
    }
    exit;
}

if (keyboard_check(global.ConfirmKey)) {
    if (z_lock) exit;
} else {
    z_lock = false;
}

if (menu_state == 0) {
    if (keyboard_check_pressed(global.RightKey) && menu_index != 2) {
        menu_index++;
        audio_play_sound(sfx_menu_move, 1, false);
    }
    if (keyboard_check_pressed(global.LeftKey) && menu_index != 0) {
        menu_index--;
        audio_play_sound(sfx_menu_move, 1, false);
    }

    if (!z_lock && keyboard_check_pressed(global.ConfirmKey)) {
        audio_play_sound(sfx_select, 1, false);
        z_lock = true;

        switch (menu_index) {
            case 0: 
                menu_state = 1; 
                menu_index = 0; 
                break;
            case 1: 
                menu_state = 2; 
                break;
            case 2: 
                menu_state = 4; 
                menu_index = 0; 
                frame_cell = 0;
                phone_submenu = false;
                alarm[0] = game_get_speed(gamespeed_fps) * 1;
                break;
        }
    }
}

//Inventario//
if (menu_state == 1) {
    if (keyboard_check_pressed(global.DownKey) && items_index < 8) {
        items_index++;
        audio_play_sound(sfx_menu_move, 1, false);
    }
    if (keyboard_check_pressed(global.UpKey) && items_index > 0) {
        items_index--;
        audio_play_sound(sfx_menu_move, 1, false);
    }
    if (keyboard_check_pressed(global.CancelKey)) {
        audio_play_sound(sfx_select, 1, false);
        menu_state = 0;
        menu_index = 0;
        items_index = 0;
    }

    if (!z_lock && keyboard_check_pressed(global.ConfirmKey)) {
        audio_play_sound(sfx_select, 1, false);
        z_lock = true;

        if (items_index < array_length(global.Inventory)) {
            menu_state = 3;
        } else if (items_index == 8) {
            menu_state = 0;
            menu_index = 0;
            items_index = 0;
        }
    }
}

// Items accion//
if (menu_state == 3) {
    if (keyboard_check_pressed(global.LeftKey)) {
        items_act_index = 0;
        audio_play_sound(sfx_menu_move, 1, false);
    }
    if (keyboard_check_pressed(global.RightKey)) {
        items_act_index = 1;
        audio_play_sound(sfx_menu_move, 1, false);
    }

    if (keyboard_check_pressed(global.CancelKey)) {
        audio_play_sound(sfx_select, 1, false);
        menu_state = 1;
        items_act_index = 0;
    }

    if (!z_lock && keyboard_check_pressed(global.ConfirmKey)) {
        z_lock = true;
        audio_play_sound(sfx_select, 1, false);

        if (items_index < array_length(global.Inventory)) {
            var item = global.Inventory[items_index];
            var _itemName = item.item_id;
            
            if (variable_struct_exists(global.Items, _itemName)) {
                var _itemData = variable_struct_get(global.Items, _itemName);
                
                var can_use = 0;
                if (variable_struct_exists(_itemData, "can_use")) {
                    can_use = _itemData.can_use;
                }
                
                if (items_act_index == 0) {  // INFO / USE//
                    if (can_use == 0) {
                        if (variable_struct_exists(_itemData, "effect")) {
                            _itemData.effect();
                        }
                    } else if (can_use == 2) {
                        // INFO y  cambiar a USE
                        if (variable_struct_exists(_itemData, "effect")) {
                            _itemData.effect();
                        }
                        _itemData.can_use = 1;
                    } else if (can_use == 1) {
                        //USAR Y ELIMINAR
                        var _delete_index = items_index;
                        array_delete(global.Inventory, _delete_index, 1);
                        
                        if (variable_struct_exists(_itemData, "effect_can_use")) {
                            _itemData.effect_can_use();
                        }
                        
                        items_index = clamp(items_index, 0, array_length(global.Inventory));
                    }
                } else {  // THROW
                    array_delete(global.Inventory, items_index, 1);
                    menu_state = 1;
                    items_act_index = 0;
                    items_index = clamp(items_index, 0, array_length(global.Inventory));
                }
            }
        }
		instance_destroy();
    }
}

// CELL
if (menu_state == 4) {
    if (keyboard_check_pressed(global.DownKey) || keyboard_check_pressed(global.UpKey)) {
        phone_submenu = !phone_submenu;
        audio_play_sound(sfx_menu_move, 1, false);
    }

    if (!z_lock && keyboard_check_pressed(global.ConfirmKey)) {
        audio_play_sound(sfx_select, 1, false);
        z_lock = true;

        if (!phone_submenu) {  // Call
            menu_state = 5;
            contact_index = 0;
            phone_submenu = false;
        } else {  // Close
            menu_state = 0;
            menu_index = 0;
            items_index = 0;
            phone_submenu = false;
        }
    }

    if (keyboard_check_pressed(global.CancelKey)) {
        menu_state = 0;
        menu_index = 0;
        items_index = 0;
        phone_submenu = false;
    }
}

// CONTACTOS//
if (menu_state == 5) {
    var max_contacts = array_length(global.PhoneContactsList);
    
    if (keyboard_check_pressed(global.DownKey) && contact_index < max_contacts) {
        contact_index++;
        audio_play_sound(sfx_menu_move, 1, false);
    }
    if (keyboard_check_pressed(global.UpKey) && contact_index > 0) {
        contact_index--;
        audio_play_sound(sfx_menu_move, 1, false);
    }

    if (keyboard_check_pressed(global.CancelKey)) {
        menu_state = 4;
        contact_index = 0;
        phone_submenu = false;
        audio_play_sound(sfx_select, 1, false);
    }

    if (!z_lock && keyboard_check_pressed(global.ConfirmKey)) {
        audio_play_sound(sfx_select, 1, false);
        z_lock = true;

        if (contact_index >= max_contacts) {
            menu_state = 4;
            contact_index = 0;
            phone_submenu = false;
        } else {
            var contact_id = global.PhoneContactsList[contact_index];
            
            if (variable_struct_exists(global.PhoneContacts, contact_id)) {
                var contact_data = variable_struct_get(global.PhoneContacts, contact_id);
                
                if (variable_struct_exists(contact_data, "effect")) {
                    menu_state = 6;
                    contact_data.effect();
                }
            }
        }
    }
}