if (combo_actual > 0 && estado_juego == "jugando") {
    
    var _hue = (combo_actual * 37) % 360;
    var _color_dinamico = make_color_hsv(_hue, 255, 255);
    combo_splash_color = _color_dinamico;
    
    var _alpha = max(0.3, combo_splash_alpha);
    draw_set_alpha(_alpha * 0.6);
	draw_sprite_ext(sprMusical_Splash, 0, 210, 168,  max(0.1, min(0.9, combo_splash_scale * 0.8)), max(0.1, min(0.9, combo_splash_scale * 0.8)), 12, combo_splash_color,1);
    draw_set_alpha(1);
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    //Shadow
    draw_set_alpha(0.5);
    draw_set_color(c_navy);
    draw_text_transformed(211, 169, string(combo_actual),0.8,0.8, 0);
    
    //Text
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_text_transformed(210, 168, string(combo_actual),0.8,0.8, 0);
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    
	//Max combo for debug
    /*
    if (combo_maximo > 0) {
        draw_set_halign(fa_right);
        draw_set_valign(fa_top);
        draw_set_color(c_aqua);
        draw_text(310, 5, "BEST: " + string(combo_maximo));
        draw_set_halign(fa_left);
    }
	*/
}