if (mostrar_pantalla_negra) {
    var _cam = view_camera;
    var _w = camera_get_view_width(_cam);
    var _h = camera_get_view_height(_cam);
    
    draw_set_color(c_black);
    draw_rectangle(0, 0, _w, _h, false);
}

if (mostrar_ranking) {
    var _cam = view_camera;
    var _w = camera_get_view_width(_cam);
    var _h = camera_get_view_height(_cam);
    
    draw_set_font(MainFont);
    
    var _cx = _w * 0.5;
    var _cy = _h * 0.5;
    
    if (mostrar_titulo) {
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text_transformed_colour(_cx, _cy - 85, "LEVEL RESULTS", 1.5, 1.5, 0, c_white, c_white, c_yellow, c_yellow, 1);
    }
    
    var _prefijos = ["1ST ", "2ND ", "3RD ", "4TH "];
    
    var _tabla_y = _cy - 30; 
    var _separacion = 22;   
    
    if (mostrar_tabla) {
        for (var i = 0; i < array_length(lista_ranking); i++) {
            var _datos_fila = lista_ranking[i];
            
            if (_datos_fila.nombre == "YOU") {
                draw_set_color(i == 2 ? c_red : c_aqua); 
            } else {
                draw_set_color(c_white);
            }
            
            draw_set_halign(fa_left);
            draw_text_transformed(_cx - 120, _tabla_y + (i * _separacion), _prefijos[i] + _datos_fila.nombre, 1, 1, 0);
            
            draw_set_halign(fa_right);
            
			if (_datos_fila.nombre == "YOU") {
			    draw_text_transformed(_cx + 140, _tabla_y + (i * _separacion), string(floor(puntaje_animado)), 1, 1, 0);
			} else {
			    draw_text_transformed(_cx + 140, _tabla_y + (i * _separacion), string(_datos_fila.puntos), 1, 1, 0);
			}

        }
    }
    
    if (mostrar_evaluacion) {
        draw_set_halign(fa_center);
        if (new_record) {
            draw_text_transformed_colour(_cx, _cy + 75, "NEW RECORD!", 1, 1, 0,c_white,c_white,c_yellow,c_yellow,1);
            
            if ((festejo_timer mod 20) < 10) {
                draw_rectangle_colour(_cx - 100, _cy + 55, _cx + 100, _cy + 95, c_yellow, c_yellow, c_yellow, c_yellow, true);
            }
        } else if(es_top_uno) {
            draw_text_transformed_colour(_cx, _cy + 75, "NUMBER 1!", 1, 1, 0,c_white,c_white,c_aqua,c_aqua,1);
		}else if(!es_top_uno){
            draw_text_transformed_colour(_cx, _cy + 75, "GOOD EFFORT!", 1, 1, 0,c_white,c_white,c_gray,c_gray,1);
        }
    }
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
