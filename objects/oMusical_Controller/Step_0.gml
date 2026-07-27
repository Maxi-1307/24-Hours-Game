if (flash_rojo_alfa > 0) {
    flash_rojo_alfa -= 0.05; 
}

if (marco_timer > 0) {
    marco_timer--;
    if (marco_timer <= 0) {
        color_marco = c_white;
    }
}

if (keyboard_check(global.CancelKey)) {
    tecla_x_timer++;
    if (tecla_x_timer >= game_get_speed(gamespeed_fps) * 1.5 && estado_juego != "resultados") {
        global.Musical_Can_Play = false;
        if (instance_exists(oMusical_Camera)) {
            oMusical_Camera.transicion_fase = "cerrando";
        }
    }
} else {
    tecla_x_timer = 0; 
}

lineas_offset_y += lineas_velocidad;
if (lineas_offset_y >= 20) {
    lineas_offset_y = 0;
}

if (estado_juego == "intro") {
    timer_intro++;

    switch (fase_intro) {
        
        case "kris_aparece":
            if (timer_intro >= game_get_speed(gamespeed_fps) * 1.2) {
                fase_intro = "conteo_3";
                timer_intro = 0;
				audio_play_sound(sfx_Countdown,1,false);
            }
            break;
            
        case "conteo_3":
            texto_conteo = "3";
            if (timer_intro >= game_get_speed(gamespeed_fps) * 1.0) {
                fase_intro = "conteo_2";
                timer_intro = 0;
				audio_play_sound(sfx_Countdown,1,false);
            }
            break;
            
        case "conteo_2":
            texto_conteo = "2";
            if (timer_intro >= game_get_speed(gamespeed_fps) * 1.0) {
                fase_intro = "conteo_1";
                timer_intro = 0;
				audio_play_sound(sfx_Countdown,1,false);
            }
            break;
            
        case "conteo_1":
            texto_conteo = "1";
            if (timer_intro >= game_get_speed(gamespeed_fps) * 1.0) {
                fase_intro = "caen_letras"; 
                texto_conteo = "";          
                timer_intro = 0;
                
                for (var i = 0; i < num_letras; i++) {
                    letra_target_y[i] = 100;
                }
            }
            break;
            
        case "caen_letras":
            if (timer_intro >= game_get_speed(gamespeed_fps) * 1.5) {
                fase_intro = "suben_letras"; 
                timer_intro = 0;
            }
            break;
            
        case "suben_letras":
            for (var i = 0; i < num_letras; i++) {
                letra_target_y[i] = -60;
            }
            
            if (timer_intro >= game_get_speed(gamespeed_fps) * 1.0) {
                fase_intro = "terminado";
                estado_juego = "jugando";
                global.Musical_Can_Play = true; 
                
                alarm[1] = game_get_speed(gamespeed_fps) * 2;
            }
            break;
    }
    
    for (var i = 0; i < num_letras; i++) {
        var _delay = (fase_intro == "suben_letras") ? (num_letras - 1 - i) : i;
        if (timer_intro >= _delay * 10) {
            letra_y[i] = lerp(letra_y[i], letra_target_y[i], 0.12); 
        }
    }
}

if (global.Musical_Can_Play && audio_stream != noone) {
    
    var _tiempo_actual = audio_sound_get_track_position(audio_stream);
    if (global.Musica_Seleccionada == snd_Test_TVWORLD) {
        
        if (_tiempo_actual >= 15.0 && _tiempo_actual < 15.1 && !variable_instance_exists(id, "_eff_tv_15")) {
            musical_camera_flash(0.7, 10);
            musical_camera_zoom(0.93, 0.12);
            _eff_tv_15 = true;
        }
        if (_tiempo_actual >= 35.0 && _tiempo_actual < 35.1 && !variable_instance_exists(id, "_eff_tv_35")) {
            musical_camera_flash(0.6, 12);
            musical_camera_zoom(0.88, 0.08);
            _eff_tv_35 = true;
        }
        if (_tiempo_actual >= 95.0 && _tiempo_actual < 95.1 && !variable_instance_exists(id, "_eff_tv_95")) {
            musical_camera_flash(1.0, 20);
            musical_camera_zoom(0.85, 0.05);
            _eff_tv_95 = true;
        }
    } 
    else if (global.Musica_Seleccionada == snd_Castle_Funk) {
        
        if (_tiempo_actual >= 30.0 && _tiempo_actual < 30.1 && !variable_instance_exists(id, "_eff_funk_30")) {
            musical_camera_flash(0.6, 8);
            musical_camera_zoom(0.92, 0.15);
            _eff_funk_30 = true;
        }
        if (_tiempo_actual >= 145.0 && _tiempo_actual < 145.1 && !variable_instance_exists(id, "_eff_funk_145")) {
            musical_camera_flash(0.9, 15);
            musical_camera_zoom(0.86, 0.06);
            _eff_funk_145 = true;
        }
    }
    
    if (_tiempo_actual >= audio_sound_length(audio_stream) - 0.05) {
        global.Musical_Can_Play = false;
        estado_juego = "resultados";
        sub_fase_final = "congelado";
        timer_final = 0;
        
        if (instance_exists(oMusical_Camera)) oMusical_Camera.is_holding_note = false;
        
        puntaje_final_real = global.Musical_Score - (global.Musical_Missed * 15);
        if (puntaje_final_real < 0) puntaje_final_real = 0;
    }
    
    while (nota_actual_index < num_total_notas && global.Musical_Can_Play) {
        
        var _datos_nota = mapa_notas[nota_actual_index];
        var _tiempo_nota = _datos_nota[0]; 
        var _carril_nota = _datos_nota[1]; 
        var _duracion_nota = (array_length(_datos_nota) > 2) ? _datos_nota[2] : 0; 
        
        var _tiempo_spawn = _tiempo_nota - 0.9;
        
        if (_tiempo_actual >= _tiempo_spawn) {
            var _nueva_nota = instance_create_layer(0, 26, "Notes", oMusical_Note);
            _nueva_nota.carril = _carril_nota; 
            _nueva_nota.duracion_sostenido = _duracion_nota;
            
            if (_duracion_nota > 0) {
                _nueva_nota.altura_cola = _duracion_nota * game_get_speed(gamespeed_fps) * _nueva_nota.velocidad_caida;
            }
            
            nota_actual_index++;
        } else {
            break;
        }
    }
}

if (estado_juego == "resultados") {
    timer_final++;
    
    switch (sub_fase_final) {
        
        case "congelado":
            if (timer_final >= game_get_speed(gamespeed_fps) * 1.5) {
                instance_destroy(oMusical_Button);
                instance_destroy(oMusical_Note);
                
                sub_fase_final = "finish_cascada";
                timer_final = 0;
                for (var i = 0; i < num_letras_finish; i++) { finish_target_y[i] = 100; }
            }
            break;
            
        case "finish_cascada":
            if (timer_final >= game_get_speed(gamespeed_fps) * 3) {
                for (var i = 0; i < num_letras_finish; i++) { finish_target_y[i] = -60; }
                sub_fase_final = "cerrar_telon";
                timer_final = 0;
            }
            break;
            
        case "cerrar_telon":
            if (timer_final >= game_get_speed(gamespeed_fps) * 1.0) {
                instance_destroy(oMusical_Player);
                sub_fase_final = "mostrar_tabla";
                timer_final = 0;
            }
            break;
            
        case "mostrar_tabla":
            if (timer_final >= game_get_speed(gamespeed_fps) * 1.0) {
                sub_fase_final = "escalando_puntos";
                timer_final = 0;
            }
            break;
            
        case "escalando_puntos":
            if (puntaje_dinamico_visual < puntaje_final_real) {
                puntaje_dinamico_visual += 2;
                if (puntaje_dinamico_visual > puntaje_final_real) puntaje_dinamico_visual = puntaje_final_real;
                
                for (var i = 0; i < num_competidores; i++) {
                    if (tabla_posiciones[i][2] == true) { 
                        tabla_posiciones[i][1] = puntaje_dinamico_visual; 
                    }
                }
                
                for (var i = 0; i < num_competidores - 1; i++) {
                    for (var j = 0; j < num_competidores - 1 - i; j++) {
                        if (tabla_posiciones[j][1] < tabla_posiciones[j+1][1]) {
                            var _temporal = tabla_posiciones[j];
                            tabla_posiciones[j] = tabla_posiciones[j+1];
                            tabla_posiciones[j+1] = _temporal;
                        }
                    }
                }
            } else {
                sub_fase_final = "veredicto";
                timer_final = 0;
                
                var _puesto_jugador = 5;
                for (var i = 0; i < num_competidores; i++) {
                    if (tabla_posiciones[i][2] == true) { _puesto_jugador = i + 1; break; }
                }
                
                if (_puesto_jugador == 1) {
                    if (puntaje_final_real > global.Musical_HighScore_Guardado) {
                        texto_veredicto = "NEW RECORD";
                        color_veredicto = make_color_rgb(255, 215, 0); 
                        global.Musical_HighScore_Guardado = puntaje_final_real; 
                    } else {
                        texto_veredicto = "WONDERFUL";
                        color_veredicto = c_yellow; 
                    }
                } else if (_puesto_jugador == 2 || _puesto_jugador == 3) {
                    texto_veredicto = "WELL DONE";
                    color_veredicto = make_color_rgb(50, 255, 100); 
                } else {
                    texto_veredicto = "NICE TRY";
                    color_veredicto = make_color_rgb(240, 60, 60); 
                }
            }
            break;
            
        case "veredicto":
            parpadeo_timer++;
            if (parpadeo_timer >= 12) {
                veredicto_visible = !veredicto_visible;
                parpadeo_timer = 0;
            }
            
            if (timer_final >= game_get_speed(gamespeed_fps) * 4.0) {
                sub_fase_final = "fin_absoluto";
                if (instance_exists(oMusical_Camera)) {
                    oMusical_Camera.transicion_fase = "cerrando";
                }
            }
            break;
    }
    
    if (sub_fase_final == "finish_cascada") {
        for (var i = 0; i < num_letras_finish; i++) {
            if (timer_final >= i * 8) { 
                finish_y[i] = lerp(finish_y[i], finish_target_y[i], 0.15); 
            }
        }
    }
}

if (global.Musical_Score >= siguiente_hito_publico) {
    siguiente_hito_publico += 200;
    instance_create_layer(160, 260, "Audience", oMusical_Audience);
}

if (modo_grabacion && global.Musical_Can_Play && audio_stream != noone) {
    if (keyboard_check_pressed(ord("Z"))) {
        var _segundo_actual = audio_sound_get_track_position(audio_stream);
        _segundo_actual = floor(_segundo_actual * 100) / 100;
        
        show_debug_message("    [" + string(_segundo_actual) + ", " + string(carril_simulado) + ", 0],");
        
        var _color_chisqa = c_white;
        var _target_x = 125;
        switch(carril_simulado) {
            case 0: _target_x = 125; _color_chisqa = make_color_rgb(255, 60, 60);  break;
            case 1: _target_x = 147; _color_chisqa = make_color_rgb(60, 255, 100); break;
            case 2: _target_x = 168; _color_chisqa = make_color_rgb(60, 180, 255); break;
            case 3: _target_x = 190; _color_chisqa = make_color_rgb(255, 230, 40); break;
        }
        repeat(4) {
            var _chispa = instance_create_layer(_target_x, 161, "Particles", oMusical_Spark);
            _chispa.color_chispa = _color_chisqa;
        }
        
        carril_simulado++;
        if (carril_simulado > 3) carril_simulado = 0;
    }
}