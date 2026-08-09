draw_set_font(MainFont);

if (option_selection == 0) {

    var button1;
    var button1_x = 270;
    if (file_exists("save_data.json")) {
        button1_x = 235;
        button1 = _T("btn_continue"); 
    } else {
        button1 = _T("btn_start");    
    }

    draw_sprite_ext(sprTitle, 0, 320 + menu_x_offset, 100, 7, 7, 0, c_white, 1);

    var base_y = menu_y_offset;

    draw_set_color(option_color(0,selection));
    draw_text_transformed(button1_x + menu_x_offset, 200 + base_y, button1, 1.5, 1.5, 0);

    draw_set_color(option_color(1,selection));
    draw_text_transformed(230 + menu_x_offset, 270 + base_y, _T("btn_settings"), 1.5, 1.5, 0); 

    draw_set_color(option_color(2,selection));
    draw_text_transformed(275 + menu_x_offset, 340 + base_y, _T("btn_quit"), 1.5, 1.5, 0); 
}


if (reset_confirm) {
    var cam_x = camera_get_view_x(view_camera[0]);
    var cam_y = camera_get_view_y(view_camera[0]);
    var cam_w = camera_get_view_width(view_camera[0]);
    var cam_h = camera_get_view_height(view_camera[0]);
    
    //Fomdo
    draw_set_alpha(0.7);
    draw_set_color(c_black);
    draw_rectangle(cam_x, cam_y, cam_x + cam_w, cam_y + cam_h, false);
    draw_set_alpha(1);
    
    //Cuadro de dialogo
    var box_w = 400;
    var box_h = 150;
    var box_x = cam_x + (cam_w / 2) - box_w / 2;
    var box_y = cam_y + (cam_h / 2) - box_h / 2;
    
    // Fondo cuadrdo
    draw_set_alpha(0.9);
    draw_set_color(c_black);
    draw_rectangle(box_x, box_y, box_x + box_w, box_y + box_h, false);
    draw_set_alpha(1);
    
    // Borde del cuadrado
    draw_set_color(c_yellow);
    draw_rectangle(box_x, box_y, box_x + box_w, box_y + box_h, true);
    
    //Title
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    draw_text_transformed(cam_x + cam_w / 2, box_y + 40, "ARE YOU SURE?", 1.5, 1.5, 0);
    
    //Subtitle
    draw_set_color(c_yellow);
    draw_text_transformed(cam_x + cam_w / 2, box_y + 80, "This will delete ALL saved progress!",0.5,0.5,0);
    
    //Opciones
    draw_set_color(c_aqua);
    draw_set_font(MainFont);
    draw_text_transformed(box_x + 80, box_y + 120, "[Z] YES", 1.2, 1.2, 0);
    
    draw_set_color(c_red);
    draw_text_transformed(box_x + box_w - 110, box_y + 120, "[X] NO", 1.2, 1.2, 0);
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}


if (menu_state == 2 || menu_state == 4) {
	if (global.Language == 0) {add = 15;}
	else
	if (global.Language == 1) {add = 0;}
	
    draw_set_color(c_white);
    draw_text_transformed(40 + settings_x_offset, 30, _T("title_settings"), 2, 2, 0); 

    draw_set_color(option_color(0,settings_index));
    draw_text(60 + settings_x_offset, 100, _T("lbl_volume")); 
    draw_bar(300 + add, 113, global.Master_Volume, 100, 10);

    draw_set_color(option_color(1,settings_index));
    draw_text(60 + settings_x_offset, 140, _T("lbl_sfx")); 
    draw_bar(235 + add, 153, global.SFX_Volume, 100, 10);
	
	draw_set_color(option_color(2,settings_index));
	var vfx_status = (global.SimplifyVFX == 1) ? "ON" : "OFF";
	draw_text(60 + settings_x_offset, 180, _T("lbl_simplifysfx") + ": " + vfx_status);

    draw_set_color(option_color(3,settings_index));
    draw_text(60 + settings_x_offset, 220, _T("lbl_controls")); 

    draw_set_color(option_color(4,settings_index));
    draw_text(60 + settings_x_offset, 260, _T("lbl_language") + string(lang[global.Language]));
	
	draw_set_colour(option_color(5,settings_index));
	var dynamic_borders = (global.BordersEnabled == 1) ? "ON" : "OFF";
	draw_text(60+settings_x_offset,300, _T("lbl_dynamicborders") + ":" + dynamic_borders);
}

if (menu_state == 3){

    draw_set_color(c_white);
    draw_text_transformed(40,30, _T("title_function"), 2, 2, 0); 
    draw_text_transformed(330,30, _T("title_key"), 2, 2, 0);       

    var options = [
        _T("ctrl_down"), _T("ctrl_up"), _T("ctrl_left"), _T("ctrl_right"), 
        _T("ctrl_confirm"), _T("ctrl_cancel"), _T("ctrl_menu"), _T("ctrl_reset"), _T("ctrl_back")
    ];
    var keys = [global.DownKey, global.UpKey, global.LeftKey, global.RightKey, global.ConfirmKey, global.CancelKey, global.MenuKey];

    var Y = 100;

    for (var i = 0; i < array_length(options); i++){

        var selected = (i == controls_index);
        var listening = (listening_key && selected);

        draw_set_color(listening ? c_red : (selected ? c_aqua : c_white));
        draw_text_transformed(40, Y + i * 40, options[i], 1.5, 1.5, 0);
        
        if (i < 7){
            var txt = key_to_string(keys[i]);
            draw_set_color(listening ? c_red : (selected ? c_aqua : c_white));
            draw_text_transformed(330, Y + i * 40, txt, 1.5, 1.5, 0);
        }
    }
}

draw_set_color(c_white);
draw_text_transformed(470, 430, "Max13", 1.5, 1.5, 0);

if(menu_state == 5){
    draw_sprite_tiled(sprite_index,image_index,0,0);
}