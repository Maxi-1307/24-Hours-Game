randomize();
option_selection = 0;
selection = 0;

menu_state = 0;

menu_y_offset = 60;
menu_target_offset = 0;

menu_x_offset = 0;

settings_index = 0;
settings_editing = false;
key_hold_timer = 0;
key_repeat_delay = 6;

lang = ["ES", "EN"]; 

settings_x_offset = 0;

function draw_bar(x, y, value, max_value, bars) {
	if(settings_x_offset == 0){
	    var filled = floor((value / max_value) * bars);

	    var size = 10;
	    var gap  = 3;

	    for (var i = 0; i < bars; i++) {

	        var bx = x + i * (size + gap);

	        if ((i < filled)) {
	            draw_set_color(c_aqua);
	            draw_rectangle(bx + settings_x_offset, y, bx + size, y + size, false);
	        } else {
	            draw_set_color(c_dkgray);
	            draw_rectangle(bx + settings_x_offset, y, bx + size, y + size, false);
	        }
	    }

	    draw_set_color(c_white);
	    draw_text(x + settings_x_offset + bars * (size + gap) + 10, y - 12, string(value) + "%");
	}
}

listening_key = false;
block_input   = false;
controls_index = 0;