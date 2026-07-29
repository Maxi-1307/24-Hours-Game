if (variable_global_exists("Is_Indoors") && !global.Is_Indoors && image_index== 1) {
    if (oTimeAtmosphere.current_alpha > 0) {
        
        gpu_set_blendmode(bm_add);
        
        var alto_foco = 50;  
        var largo_haz = 60;  
        var ancho_foco = 4;   
        var ancho_haz_suelo = 28;  
        
        var ajuste_x  = 6;   
        var color_luz  = make_color_rgb(255, 235, 160);
        var alfa_base  = oTimeAtmosphere.current_alpha * 0.75;
        
        var fx = x + ajuste_x;            
        var fy = y - alto_foco;
        var suelo_y = fy + largo_haz;
        
        for (var yy = 0; yy < largo_haz; yy++) {
            var factor = yy / largo_haz;
            var ancho_actual = floor(lerp(ancho_foco, ancho_haz_suelo, factor));
            
            draw_set_alpha(alfa_base * lerp(0.55, 0.15, factor));
            draw_set_color(color_luz);
            draw_rectangle(fx - ancho_actual, fy + yy, fx + ancho_actual, fy + yy + 1, false);
        }
        
        draw_set_alpha(alfa_base * 0.85);
        draw_rectangle(fx - 2, fy - 2, fx + 2, fy + 2, false);
        
        random_set_seed(id); 
        draw_set_color(c_white); 
        var total_particulas = 8; 
        
        for (var p = 0; p < total_particulas; p++) {
            var altura_inicial = random(largo_haz);
            var tiempo_movimiento = (global.game_minutes * 0.8) + p;
            var progreso_seno = (sin(tiempo_movimiento) + 1) / 2; 
            var progreso_y = progreso_seno * largo_haz;
            
            var particula_y = floor(fy + progreso_y);
            var factor_ancho = progreso_y / largo_haz;
            var ancho_actual = floor(lerp(ancho_foco, ancho_haz_suelo, factor_ancho));
            
            var balanceo = sin((global.game_minutes * 0.5) + p) * 1.5;
            var particula_x = floor(fx + random_range(-ancho_actual * 0.6, ancho_actual * 0.6) + balanceo);
            
            if (particula_y < suelo_y && particula_y > fy) {
                draw_set_alpha(random_range(0.4, 0.8));
                draw_point(particula_x, particula_y);
            }
        }
        
        randomize();
        draw_set_alpha(1);
        gpu_set_blendmode(bm_normal);
    }
}
