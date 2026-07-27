if (!siendo_cargada) {
    mask_index = sprite_index;

    if (tiene_globo) {
        vel_vertical = 0; 
        
        if (y > altura_ancla_y - 40) {
            y -= 1; 
        } else {
            y = altura_ancla_y - 40;
        }
        
        if (instance_exists(globo_id)) {
            globo_id.x = x;
            globo_id.y = y - 16; 
        }
        
        if (distancia_a_mover_x > 0) {
            var _paso_x = min(velocidad_empuje, distancia_a_mover_x);
            
            var _choca_muro = place_meeting(x + (direccion_empuje * _paso_x), y, oWall);
            
            var _enemigo_slime  = instance_place(x + (direccion_empuje * _paso_x), y, oPlatformer_Enemy_Slime);
            var _enemigo_glomy  = instance_place(x + (direccion_empuje * _paso_x), y, oPlatformer_Enemy_Glomy);
            
            var _choca_enemigo = (_enemigo_slime != noone) || (_enemigo_glomy != noone);
            
            if (!_choca_muro && !_choca_enemigo) {
                x += direccion_empuje * _paso_x;
                distancia_a_mover_x -= _paso_x; 
            } 
            else if (_choca_enemigo) {
                if (instance_exists(globo_id)) {
                    with (globo_id) instance_destroy(); 
                }
                tiene_globo = false;
                globo_id = noone;
                
                distancia_a_mover_x = 0; 
                vel_vertical = 0;
            }
            else if (_choca_muro) {
                with (globo_id) {
                    if (!place_meeting(x + direccion_empuje, y, oWall)) {
                        x += direccion_empuje;
                    }
                }
                distancia_a_mover_x = 0; 
            }
        } else {
            var _jugador = instance_find(oPlatformer_Kid, 0);
            if (_jugador != noone) {
                var _distancia_x = abs(x - _jugador.x);
                var _en_altura_correcta = (y >= _jugador.y - 24 && y <= _jugador.y + 24);
                
                if (_distancia_x <= 20 && _en_altura_correcta && _jugador.vel_horizontal != 0) {
                    direccion_empuje = sign(x - _jugador.x);
                    if (direccion_empuje == 0) direccion_empuje = sign(_jugador.image_xscale);
                    
                    distancia_a_mover_x = 40; 
                }
            }
        }
        
    } else {
        distancia_a_mover_x = 0; 
        
        var _tocando_suelo = place_meeting(x, y + 1, oWall) || place_meeting(x, y + 1, oPlatformer_Button);
        
        if (!_tocando_suelo) {
            vel_vertical += gravedad;
        } else {
            vel_vertical = 0;
        }

        if (place_meeting(x, y + vel_vertical, oWall)) {
            while (!place_meeting(x, y + sign(vel_vertical), oWall)) {
                y += sign(vel_vertical);
            }
            vel_vertical = 0;
        }
        y += vel_vertical;
    }
} else {
    mask_index = -1; 
    distancia_a_mover_x = 0;
}
