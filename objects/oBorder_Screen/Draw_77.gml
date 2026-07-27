depth = -9999;
var _w = window_get_width();
var _h = window_get_height();

if (window_get_fullscreen()) {
    
    if (global.BordersEnabled) {

        draw_set_color(c_black);
        draw_rectangle(0, 0, _w, _h, false);
        var juego_base_w = 640;
        var juego_base_h = 480;
        
        var alto_deseado = _h - 76;
        var escala = alto_deseado / juego_base_h;

        var juego_final_w = juego_base_w * escala;
        var juego_final_h = juego_base_h * escala;

        var posX = (_w - juego_final_w) / 2;
        var posY = (_h - juego_final_h) / 2;

        gpu_set_blendenable(false);
        draw_surface_stretched(application_surface, posX, posY, juego_final_w, juego_final_h);
        gpu_set_blendenable(true);
		
        var color_borde = c_white;
        if (instance_exists(oTimeAtmosphere)) { 
            var color_ambiente = oTimeAtmosphere.current_color;
            var alpha_ambiente = oTimeAtmosphere.current_alpha;
            color_borde = merge_color(c_white, color_ambiente, 0.40);
            var factor_oscuridad = 1.0 - (alpha_ambiente * 0.45); 
            color_borde = merge_color(c_black, color_borde, factor_oscuridad);
        }

        if (borde_anterior != noone) {
            draw_sprite_stretched_ext(borde_anterior, 0, 0, 0, _w, _h, color_borde, 1.0 - borde_alpha);
        }

        if (borde_sprite != noone) {
            draw_sprite_stretched_ext(borde_sprite, 0, 0, 0, _w, _h, color_borde, borde_alpha);
        }

    } else {
        draw_set_color(c_black);
        draw_rectangle(0, 0, _w, _h, false);

        var juego_base_w = 640;
        var juego_base_h = 480;
        var escala = _h / juego_base_h;

        var juego_final_w = juego_base_w * escala;
        var juego_final_h = _h; 

        var posX = (_w - juego_final_w) / 2;
        var posY = 0;

        gpu_set_blendenable(false);
        draw_surface_stretched(application_surface, posX, posY, juego_final_w, juego_final_h);
        gpu_set_blendenable(true);
    }

} else {
    gpu_set_blendenable(false);
    draw_surface_stretched(application_surface, 0, 0, _w, _h);
    gpu_set_blendenable(true);
}
