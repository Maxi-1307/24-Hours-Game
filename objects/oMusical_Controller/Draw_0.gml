if (estado_juego != "resultados" || (estado_juego == "resultados" && sub_fase_final == "congelado") || sub_fase_final == "finish_cascada") {

    draw_sprite_ext(sprMusical_Container, image_index, 157.5, 100.5, 4.85, 7.65, 0, color_marco, 1);

    var _pista_izq = 115;
    var _pista_der = 198;
    var _pista_top = 26;
    var _pista_bot = 167;

    draw_set_color(c_navy); 
    var _espaciado_lineas = 20; 

    for (var _yy = _pista_top + lineas_offset_y; _yy < _pista_bot + _espaciado_lineas; _yy += _espaciado_lineas) {
        if (_yy >= _pista_top && _yy <= _pista_bot) {
            draw_line(_pista_izq, _yy, _pista_der, _yy);
        }
    }

    draw_set_color(c_white);
    draw_text_transformed_colour(5, 9, "MISSED:" + string(global.Musical_Missed), 0.7, 0.7, 0, c_white, c_white, c_red, c_red, 1);
    draw_text_transformed_colour(135, 0, "YOU", 0.75, 0.75, 0, c_white, c_white, c_ltgrey, c_ltgrey, 1);
    draw_text_transformed_colour(205, 9, "SCORE: " + string(floor(global.Musical_Score)), 0.63, 0.63, 0, c_navy, c_navy, c_navy, c_navy, 1);
    draw_text_transformed(206, 9, "SCORE: " + string(floor(global.Musical_Score)), 0.63, 0.63, 0);
    
    // Controles
    draw_text_transformed(234,133,"(" + key_to_string(global.CancelKey) + ") Exit",0.5,0.5,0);
    draw_sprite_ext(sprMusical_Shapes,0,242,159,0.7,0.7,0,c_white,1);
    draw_text_transformed(250,151,"(" + key_to_string(global.LeftKey) + ")",0.5,0.5,0);
    draw_sprite_ext(sprMusical_Shapes,1,242,175,0.7,0.7,0,c_white,1);
    draw_text_transformed(250,167,"(" + key_to_string(global.DownKey) + ")",0.5,0.5,0);
    draw_sprite_ext(sprMusical_Shapes,2,242,191,0.7,0.7,0,c_white,1);
    draw_text_transformed(250,183,"(" + key_to_string(global.UpKey) + ")",0.5,0.5,0);
    draw_sprite_ext(sprMusical_Shapes,3,242,207,0.7,0.7,0,c_white,1);
    draw_text_transformed(250,199,"(" + key_to_string(global.RightKey) + ")",0.5,0.5,0);
    
    if (estado_juego == "intro" && (fase_intro == "caen_letras" || fase_intro == "suben_letras")) {
        draw_set_color(c_white);
        for (var i = 0; i < num_letras; i++) {
            var _base_x = 90 + (i * 30); 
            draw_text_transformed_colour(_base_x, letra_y[i], letras[i], 1.8, 1.8, 0, c_white, c_white, c_yellow, c_yellow, 1);
        }
    }

    if (texto_conteo != "") {
        draw_set_color(c_white);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        
        draw_text_transformed(160, 120, texto_conteo, 2.5, 2.5, 0);
        
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
    }
}

if (estado_juego == "resultados" && sub_fase_final == "finish_cascada") {
    draw_set_color(c_white);
    for (var i = 0; i < num_letras_finish; i++) {
        var _base_finish_x = 75 + (i * 25);
        draw_text_transformed_colour(_base_finish_x, finish_y[i], letras_finish[i], 1.6, 1.6, 0, c_white, c_white, c_orange, c_orange, 1);
    }
}

if (estado_juego == "resultados" && (sub_fase_final == "mostrar_tabla" || sub_fase_final == "escalando_puntos" || sub_fase_final == "veredicto")) {
    
    draw_set_color(c_black);
    draw_rectangle(0, 0, room_width, room_height, false);
    
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_text_transformed_colour(160, 15, "SCORE RESULTS", 1.2, 1.2, 0, c_white, c_white, c_aqua, c_aqua, 1);
    
    draw_set_halign(fa_left);
    var _tabla_start_y = 48;
    var _espaciado_filas = 23;
    
    for (var i = 0; i < num_competidores; i++) {
        var _yy = _tabla_start_y + (i * _espaciado_filas);
        var _nombre = tabla_posiciones[i][0];
        var _puntos = floor(tabla_posiciones[i][1]);
        var _es_jugador = tabla_posiciones[i][2];
        
        var _color_fila = _es_jugador ? c_yellow : c_white;
        
        draw_text_transformed_color(60,  _yy, string(i + 1) + ". " + _nombre, 0.8, 0.8, 0, _color_fila, _color_fila, _color_fila, _color_fila, 1);
        draw_text_transformed_color(200, _yy, string(_puntos) + " PTS", 0.8, 0.8, 0, _color_fila, _color_fila, _color_fila, _color_fila, 1);
    }
    if (sub_fase_final == "veredicto" && texto_veredicto != "") {
        if (veredicto_visible) {
            draw_set_halign(fa_center);
            var _box_x = 160;
            var _box_y = 185;
            
            draw_set_color(color_veredicto);
            draw_rectangle(_box_x - 65, _box_y - 2, _box_x + 75, _box_y + 12, true);
            draw_rectangle(_box_x - 66, _box_y - 3, _box_x + 76, _box_y + 13, true); 
            
            draw_text_transformed_color(_box_x, _box_y, texto_veredicto, 0.9, 0.9, 0, color_veredicto, color_veredicto, color_veredicto, color_veredicto, 1);
        }
    }
    
    draw_set_halign(fa_left);
}

if (flash_rojo_alfa > 0 && sub_fase_final != "mostrar_tabla" && sub_fase_final != "escalando_puntos" && sub_fase_final != "veredicto") {
    draw_set_alpha(flash_rojo_alfa);
    draw_set_color(c_red);
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_alpha(1.0);
}