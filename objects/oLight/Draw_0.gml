event_inherited();
if (variable_global_exists("Is_Indoors") && !global.Is_Indoors) {
    if (oTimeAtmosphere.current_alpha > 0) {
        
        gpu_set_blendmode(bm_add);
        
        var alto_foco = 50;  
        var largo_haz  = 60;
        var ancho_haz_suelo = 28;  
        var alto_ovalo = 7;   
        
        var ajuste_x  = 6;
        var color_luz = make_color_rgb(255, 235, 160);
        
        var alfa_suelo      = oTimeAtmosphere.current_alpha * 0.90; 
        if (alfa_suelo > 0.95) alfa_suelo = 0.95;
        
        var fx = x + ajuste_x;
        var suelo_y = (y - alto_foco) + largo_haz;
        
        for (var oy = -alto_ovalo; oy <= alto_ovalo; oy++) {
            var factor_forma = sqrt(1 - (oy * oy) / (alto_ovalo * alto_ovalo));
            var pixel_actual_y = suelo_y + oy;
            
            var ancho_fila_suelo = floor(ancho_haz_suelo * 1.3 * factor_forma);
            draw_set_alpha(alfa_suelo * 0.55);
            draw_set_color(color_luz);
            draw_rectangle(fx - ancho_fila_suelo, pixel_actual_y, fx + ancho_fila_suelo, pixel_actual_y + 1, false);
            
            var ancho_nucleo = floor(ancho_haz_suelo * 0.7 * factor_forma);
            draw_set_alpha(alfa_suelo * 0.85);
            draw_rectangle(fx - ancho_nucleo, pixel_actual_y, fx + ancho_nucleo, pixel_actual_y + 1, false);
        }
        
        draw_set_alpha(1);
        gpu_set_blendmode(bm_normal);
    }
}
