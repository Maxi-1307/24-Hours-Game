if (menu_state == 6) {
    exit;
}

draw_set_font(MainFont);
draw_set_colour(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var camera_x = camera_get_view_x(view_camera[0]);
var camera_y = camera_get_view_y(view_camera[0]);

// FADE
if (menu_state == 2) {
    sprite_index = sprFade;
    image_speed = 0.25;
    draw_sprite_tiled(sprite_index, image_index, 0, 0);
}

//INVENTARIO
if (menu_state == 0) {
    draw_rectangle_colour(camera_x + 0, camera_y + 190, camera_x + 320, camera_y + 240, c_black, c_black, c_black, c_black, false);

    // ITEMS
    draw_sprite_ext(sprItems_Icon, 0, camera_x + 50, camera_y + 160, 2, 2, 0, c_white, 1);
    draw_set_colour(option_color(0, menu_index));
    draw_text_transformed(camera_x + 10, camera_y + 200, "ITEMS", 1, 1, 0);
    
    // TITLE
    draw_sprite_ext(sprReturn, 0, camera_x + 150, camera_y + 160, 2, 2, 0, c_white, 1);
    draw_set_colour(option_color(1, menu_index));
    draw_text_transformed(camera_x + 110, camera_y + 200, "TITLE", 1, 1, 0);
    
    // CELL
    draw_sprite_ext(sprCellPhone_Icon, 0, camera_x + 250, camera_y + 160, 2, 2, 0, c_white, 1);
    draw_set_colour(option_color(2, menu_index));
    draw_text_transformed(camera_x + 220, camera_y + 200, "PHONE", 1, 1, 0);
}


var cam = view_camera[0];
var cam_x = camera_get_view_x(cam);
var cam_y = camera_get_view_y(cam);
var cam_w = camera_get_view_width(cam);
var cam_h = camera_get_view_height(cam);
  
var start_x = cam_x + cam_w * 0.5 - 50;
var start_y = cam_y + 20;

var max_slots = global.InventoryLength;

var cursor_x = start_x - 10;
var cursor_y = start_y + 16;

if (menu_state == 1 || menu_state == 3) {
    draw_sprite_ext(sprTextBox, 0, cam_x + cam_w * 0.5, cam_y + 110, 2.5, 2.8, 0, c_white, 1);
    
    if (menu_state == 3) {
        draw_sprite_ext(sprCursor, 0, cursor_x + (items_act_index * 70), camera_y + 180, 1, 1, 0, c_white, 1);
    } else {
        draw_sprite_ext(sprCursor, 0, cursor_x, cursor_y + (items_index * 18), 1, 1, 0, c_white, 1);
    }
    
    for (var i = 0; i < max_slots; i++) {
        var item_name = "-------";

        if (i < array_length(global.Inventory)) {
            var _id = global.Inventory[i].item_id;
            
            if (variable_struct_exists(global.Items, _id)) {
                var _etiqueta_json = global.Items[$ _id].name;
                item_name = _T(_etiqueta_json);
            } else {
                item_name = _id;
            }
        }
        draw_set_colour(option_color(i, items_index));
        draw_text_transformed(start_x, start_y + i * 18, item_name, 0.8, 0.8, 0);
    }
}

// ITEMS
if (menu_state == 3) {
    var can_use = 0;
    
    if (items_index < array_length(global.Inventory)) {
        var item = global.Inventory[items_index];
        var _itemName = item.item_id;
        
        if (variable_struct_exists(global.Items, _itemName)) {
            var _itemData = variable_struct_get(global.Items, _itemName);
            if (variable_struct_exists(_itemData, "can_use")) {
                can_use = _itemData.can_use;
            }
        }
    }
    
    var use_text = "INFO";
    if (can_use == 1) {
        use_text = "USE";
    } else if (can_use == 0 || can_use == 2) {
        use_text = "INFO";
    }
    
    draw_set_colour(c_white);
    draw_text_transformed(start_x, camera_y + 170, use_text, 0.7, 0.7, 0);
    draw_text_transformed(camera_x + 180, camera_y + 170, "THROW", 0.7, 0.7, 0);
} else if (menu_state == 1) {
    draw_set_colour(option_color(8, items_index));
    draw_text_transformed(start_x, camera_y + 170, "BACK", 0.7, 0.7, 0);
    draw_set_colour(c_white);
    draw_text_transformed(camera_x + 180, camera_y + 170, "$" + string(global.Money), 0.7, 0.7, 0);
}

// ===== TELÉFONO (menu_state = 4) =====
if (menu_state == 4) {
    var total = floor(global.game_minutes);
    var hours = (total div 60) mod 24;
    var minutes = total mod 60;
    var h = string_replace_all(string_format(hours, 2, 0), " ", "0");
    var m = string_replace_all(string_format(minutes, 2, 0), " ", "0");
    
    draw_sprite_ext(sprCellPhone_UI, frame_cell, camera_x + 270, camera_y + 170, 2.5, 3, 0, c_white, 1);
    
    if (frame_cell == 1) {
        draw_text_transformed(camera_x + 244, camera_y + 130, h + ":" + m, 0.6, 0.6, 0);
        draw_text_transformed(camera_x + 244, camera_y + 150, "Sunday", 0.5, 0.5, 0);
        
        // Call
        var call_color = !phone_submenu ? c_aqua : c_white;
        draw_set_colour(call_color);
        draw_text_transformed(camera_x + 244, camera_y + 170, "Call", 0.5, 0.5, 0);
        
        // Close
        var close_color = phone_submenu ? c_aqua : c_white;
        draw_set_colour(close_color);
        draw_text_transformed(camera_x + 244, camera_y + 190, "Close", 0.5, 0.5, 0);
        
        // Cursor
        var cursor_y2 = camera_y + 180 + (phone_submenu ? 20 : 0);
        draw_sprite_ext(sprCursor, 0, camera_x + 230, cursor_y2, 0.7, 0.7, 0, c_white, 1);
        
        draw_set_colour(c_white);
    }
}

//CONTACTS//
if (menu_state == 5) {
    draw_sprite_ext(sprCellPhone_UI, frame_cell, camera_x + 270, camera_y + 170, 2.5, 3, 0, c_white, 1);
    
    if (frame_cell == 1) {
        draw_set_colour(c_white);
        draw_text_transformed(camera_x + 244, camera_y + 125, "CALL", 0.5, 0.5, 0);
        
        var contact_y = 145;
        var max_contacts = array_length(global.PhoneContactsList);
        
        for (var i = 0; i < max_contacts; i++) {
            var contact_id = global.PhoneContactsList[i];
            var color = (i == contact_index) ? c_aqua : c_white;
            
            if (variable_struct_exists(global.PhoneContacts, contact_id)) {
                var contact_data = variable_struct_get(global.PhoneContacts, contact_id);
                var display_name = contact_data.name;
                draw_set_colour(color);
                draw_text_transformed(camera_x + 244, camera_y + contact_y, display_name, 0.5, 0.5, 0);
                contact_y += 16;
            }
        }
        
        //BACK
        var volver_color = (contact_index >= max_contacts) ? c_aqua : c_white;
        draw_set_colour(volver_color);
        draw_text_transformed(camera_x + 244, camera_y + contact_y, "Back", 0.5, 0.5, 0);
        
        //CURSOR
        var cursor_x3 = camera_x + 230;
        var cursor_y3 = camera_y + 155 + (contact_index * 15);
        draw_sprite_ext(sprCursor, 0, cursor_x3, cursor_y3, 0.7, 0.7, 0, c_white, 1);
        
        draw_set_colour(c_white);
    }
}