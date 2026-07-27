if (intro_state < 3) {
    draw_set_color(c_black);
    draw_rectangle(0, 0, 320, 240, false);
}

if (show_text) {
    var str_h = string_replace_all(string_format(hours, 2, 0), " ", "0");
    var str_m = string_replace_all(string_format(minutes, 2, 0), " ", "0");
    var str_s = string_replace_all(string_format(seconds, 2, 0), " ", "0");
    
    var reloj_texto = str_h + ":" + str_m + ":" + str_s;
    
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(center_x, center_y, reloj_texto);
	draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

if (intro_state == 3 || intro_state == 4) {
    draw_set_alpha(fade_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, 320, 240, false);
    draw_set_alpha(1);
}
