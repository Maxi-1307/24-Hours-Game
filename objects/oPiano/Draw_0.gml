if(using_piano){
    depth = oPlayer.depth - 1;

    var cam = view_camera[0];

    var cx = camera_get_view_x(cam);
    var cy = camera_get_view_y(cam);

    var gui_w = 320;
    var gui_h = 240;

    draw_set_alpha(0.45);
    draw_set_color(c_black);
    draw_rectangle(cx, cy, cx + gui_w, cy + gui_h, false);

    var bar_h = 85;
    var bar_y = 37;

    draw_set_alpha(0.80);
    draw_rectangle(cx,cy + bar_y,cx + gui_w,cy + bar_y + bar_h,false);

    draw_set_alpha(1);

    draw_set_halign(fa_center);
    draw_set_color(c_white);

    draw_text_transformed(cx + gui_w * 0.5, cy + bar_y - 14,"Piano - Octava " + string(current_octave),0.5,0.5,0);

    var notes;

    if(!sharp_mode)
    {
        notes = [
            "C","D","E","F",
            "G","A","B","C"
        ];
    }
    else
    {
        notes = [
            "C#","D#","E","F#",
            "G#","A#","B","C#"
        ];
    }

    var start_x = 40;
    var spacing = 35;

    for(var i = 0; i < 8; i++){
        var xx = start_x + spacing * i;


        var txt_alpha = 0.35;
        var txt_color;

		if(i == current_note){
		    draw_set_color(c_yellow);
		}else{
		    if(sharp_mode){
		        if(i==0||i==1||i==3||i==4||i==5||i==7){
		            draw_set_color(c_red);
				} else{
		            draw_set_color(c_white);
				}
		    }else {
		        draw_set_color(c_white);
		    }
		}

		draw_set_alpha(1);

		draw_text_transformed(cx + xx,  cy + bar_y + 4,notes[i],0.55,0.55, 0);


		var arrow_scale = 1.25;
		var arrow_alpha = 0.35;

		if(i == piano_flash){
		    arrow_scale = 1.55;
		    arrow_alpha = 1;
		}

		draw_sprite_ext(sprPianoArrows,i,cx + xx,cy + bar_y + 45,arrow_scale,arrow_scale,0,c_white,arrow_alpha);

    draw_set_alpha(1);
	}
	

    draw_set_halign(fa_right);

    draw_set_color(c_white);

    draw_text_transformed(cx + gui_w - 8,cy + bar_y + bar_h + 17, "(" + key_to_string(global.ConfirmKey) + ") Play", 0.65,0.65,0);

    draw_text_transformed(cx + gui_w - 8,cy + bar_y + bar_h + 38,"(" + key_to_string(global.CancelKey) + ") Semitones",0.65,0.65,0);

    draw_text_transformed(cx + gui_w - 8,cy + bar_y + bar_h + 59,"(" + key_to_string(global.MenuKey) + ") Octave",0.65, 0.65, 0);

    var progress = clamp(hold_exit / (game_get_speed(gamespeed_fps) * 3),0,1);

    draw_set_color( merge_color(c_white, c_aqua, progress));

    draw_text_transformed(cx + gui_w - 8,cy + bar_y + bar_h + 80,"Hold (" + key_to_string(global.CancelKey) + ") Exit", 0.65, 0.65,0);

    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_halign(fa_left);
}