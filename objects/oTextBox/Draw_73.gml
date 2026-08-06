if (array_length(text) == 0) exit;

var cam = view_camera[0];
var cam_x = camera_get_view_x(cam);
var cam_y = camera_get_view_y(cam);
var cam_w = camera_get_view_width(cam);
var cam_h = camera_get_view_height(cam);

var cam_scale_x = cam_w / base_cam_w;
var cam_scale_y = cam_h / base_cam_h;

var box_draw_x = cam_x + base_box_draw_x * cam_scale_x;

var target_y;
if (instance_exists(oPlayer)) target_y = oPlayer.y;
else target_y = cam_y + cam_h * 0.5;
var cam_mid_y = cam_y + cam_h * 0.5;
if (abs(target_y - cam_mid_y) > 20) {
    textbox_side = (target_y > cam_mid_y) ? -1 : 1;
}
var desired_y = (textbox_side == 1)
    ? cam_y + base_box_draw_y * cam_scale_y
    : cam_y + 22 * cam_scale_y;
target_box_y = lerp(target_box_y, desired_y, 0.2);
var box_draw_y = target_box_y;

if (!setup) {
    setup = true;
    page_number = array_length(text);
    for (var i = 0; i < page_number; i++) {
        parsed[i] = parse_text(text[i]);
        text_length[i] = array_length(parsed[i].chars);
        text_x_offset[i] = 17;
        portrait_x_offset[i] = -60;
    }
    global.CanMove = false;
    global.CanInventory = false;
    draw_set_font(text_font);
    draw_set_valign(fa_top);
    draw_set_halign(fa_left);
}

// Color del cuadro
var box_color = c_white;
if (array_length(txtb_color) > page) box_color = txtb_color[page];
if(choosing){
	box_color = c_white;
}
var spr_w = sprite_get_width(txtb_sprite);
var spr_h = sprite_get_height(txtb_sprite);
draw_sprite_ext(txtb_sprite, 0,box_draw_x, box_draw_y,(textbox_width / spr_w) * cam_scale_x,(textbox_height / spr_h) * cam_scale_y,0, box_color, 1);

// Speaker
var speaker_offset = 0;
if (speaker_sprite[page] != noone && !choosing) {
    speaker_offset = 40;
    var spr = speaker_sprite[page];
    var sw = sprite_get_width(spr);
    var sh = sprite_get_height(spr);
    
    var target_size = 40;
    var base_scale = target_size / max(sw, sh);
    var final_scale = base_scale * cam_scale_x;
    
    // ANIMA SOLO CUANDO ESTÁ TYPEANDOSE:
    // Comparamos los caracteres dibujados actuales con el largo total del texto
    if (draw_char < text_length[page]) {
        // Avanza el frame sumando la velocidad real configurada en el sprite por cada paso (delta_time independiente)
        var spr_spd = sprite_get_speed(spr) / game_get_speed(gamespeed_fps);
        speaker_img += spr_spd; 
    } else {
        // Cuando termina de escribir, vuelve al primer frame (boca cerrada)
        speaker_img = 0; 
    }
    
    // Dibujamos usando nuestra variable "speaker_img"
    draw_sprite_ext(spr, speaker_img, box_draw_x + portrait_x_offset[page] * cam_scale_x, box_draw_y, final_scale, final_scale, 0, c_white, 1);
}


// Texto
var data = parsed[page];
if (!choosing) {
    var real_scale_x = base_text_scale_x * cam_scale_x;
    var real_line_width = (textbox_width * 2 + 90) * cam_scale_x;
    var lines = wrap_text_to_lines(data.chars, real_line_width, real_scale_x);
	
    draw_textbox_final_lines( box_draw_x + (text_x_offset[page] + border + speaker_offset) * cam_scale_x,box_draw_y + bordery * cam_scale_y,data, lines, draw_char, line_sep,base_text_scale_x * cam_scale_x,base_text_scale_y * cam_scale_y);
}

// Decisiones
if (choosing) {
    var d = decisions[page];
    if (is_struct(d)) {
        
        var _cx = camera_get_view_x(view_camera);
        var _cy = camera_get_view_y(view_camera);

        var _base_x = floor(_cx + 160); 
		var offset_y = (textbox_side == 1) 
		 ? cam_scale_y - 2
		: cam_scale_y - 2;

		var _base_y = floor(box_draw_y + offset_y);

        var _gap_x = 50;
        var _gap_y = 20;

        var draw_opt_with_cursor = function(_txt, _x, _y, _dir) {
            var is_selected = (choice_dir == _dir);
            
            var _txt_scale = 0.7; 
            
            draw_set_halign(fa_center);
            draw_set_valign(fa_middle);
            
            var _base_color = is_selected ? c_aqua : c_white;
            
            var _shadow_color = (_base_color == c_white) ? c_dkgray : merge_colour(_base_color, c_black, 0.65);
            var _bottom_color = merge_colour(_base_color, c_black, 0.35);
            
            draw_text_transformed_colour(floor(_x) + 1, floor(_y) + 1, _txt, _txt_scale, _txt_scale, 0, _shadow_color, _shadow_color, _shadow_color, _shadow_color,  1);
            
            draw_text_transformed_colour(floor(_x), floor(_y), _txt,  _txt_scale, _txt_scale, 0,_base_color, _base_color, _bottom_color, _bottom_color, 1 );
            
            if (is_selected) {
                var _tw = string_width(_txt) * _txt_scale;
                var _cursor_x = floor(_x - (_tw * 0.5) - 12);
                var _cursor_y = floor(_y);
                
                draw_sprite_ext(sprCursor, 0, _cursor_x, _cursor_y, 0.9, 0.9, 0, c_white, 1);
            }
        }

		if (variable_struct_exists(d, "up"))    
		    draw_opt_with_cursor(d.up,    _base_x, _base_y - 20, "up"); 

		if (variable_struct_exists(d, "down"))  
		    draw_opt_with_cursor(d.down,  _base_x, _base_y + 20, "down"); 

		if (variable_struct_exists(d, "left"))  
		    draw_opt_with_cursor(d.left,  _base_x - 55, _base_y, "left");  

		if (variable_struct_exists(d, "right")) 
		    draw_opt_with_cursor(d.right, _base_x + 55, _base_y, "right"); 

        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_set_color(c_white);
    }
}
