switch(carril) {
    case 0: tecla_global = global.LeftKey;  break;
    case 1: tecla_global = global.DownKey;  break;
    case 2: tecla_global = global.UpKey;    break;
    case 3: tecla_global = global.RightKey; break;
}

image_index = 4 + carril;

if (!global.Musical_Can_Play) {
    alfa_actual = 0.5;
    exit;
}

if (keyboard_check(tecla_global)) {
    alfa_actual = 1.0;
    
    if (keyboard_check_pressed(tecla_global)) {
        escala_x = 1.25; 
        escala_y = 1.25; 
        
        var _nota_cercana = noone;
        var _mayor_y = -999; 
        
        with (oMusical_Note) {
            if (carril == other.carril && !siendo_sostenida && !nota_fallada) {
                if (y > _mayor_y) {
                    _mayor_y = y;
                    _nota_cercana = id;
                }
            }
        }
        
        if (_nota_cercana != noone) {
            var _distancia_pixeles = abs(_nota_cercana.y - y); 
            
            if (_distancia_pixeles <= oMusical_Controller.margen_asistencia) {
                global.Musical_Score += 10;
                var _color_chispa = c_white;
                switch(carril) {
                    case 0: _color_chispa = make_color_rgb(255, 60, 60);   break;
                    case 1: _color_chispa = make_color_rgb(60, 255, 100);  break;
                    case 2: _color_chispa = make_color_rgb(60, 180, 255);  break;
                    case 3: _color_chispa = make_color_rgb(255, 230, 40);  break;
                }

                repeat(3) { 
                    var _nueva_chispa = instance_create_layer(x, y, "Particles", oMusical_Spark);
                    _nueva_chispa.color_chispa = _color_chispa;
                }


                
                if (instance_exists(oMusical_Camera)) {
                    oMusical_Camera.cam_angle_target = (carril <= 1) ? -1 : 1;
                }
                
                if (_nota_cercana.duracion_sostenido > 0) {
                    _nota_cercana.siendo_sostenida = true;
                } else {
                    instance_destroy(_nota_cercana); 
                }
            }
        }
    }
    
    var _sosteniendo_ahora = false;
    with (oMusical_Note) {
        if (carril == other.carril && siendo_sostenida && !nota_fallada) {
            _sosteniendo_ahora = true;
        }
    }
    
    if (_sosteniendo_ahora) {
        global.Musical_Score += 0.15;
                var _color_chispa = c_white;
                switch(carril) {
                    case 0: _color_chispa = make_color_rgb(255, 60, 60);   break;
                    case 1: _color_chispa = make_color_rgb(60, 255, 100);  break;
                    case 2: _color_chispa = make_color_rgb(60, 180, 255);  break;
                    case 3: _color_chispa = make_color_rgb(255, 230, 40);  break;
                }

                repeat(3) { 
                    var _nueva_chispa = instance_create_layer(x, y, "Particles", oMusical_Spark);
                    _nueva_chispa.color_chispa = _color_chispa;
                }

        if (instance_exists(oMusical_Camera)) oMusical_Camera.is_holding_note = true;
    }
    
} else {
    alfa_actual = 0.5;

    with (oMusical_Note) {
        if (carril == other.carril && siendo_sostenida && !nota_fallada) {
            nota_fallada = true;
            
            if (instance_exists(oMusical_Camera)) {
                oMusical_Camera.is_holding_note = false; 
            }
        }
    }


}

escala_x = lerp(escala_x, escala_base, 0.2);
escala_y = lerp(escala_y, escala_base, 0.2);
