var _jugador = instance_find(oPlatformer_Kid, 0);
var _vel_actual = velocidad_patrulla;

if (estado == "patrulla") {
    _vel_actual = velocidad_patrulla;
    vel_vertical = 0; 
    
    if (!variable_instance_exists(id, "ancla_x")) {
        ancla_x = x;
    }
    
    var _distancia_al_ancla = x - ancla_x;
    if (abs(_distancia_al_ancla) >= 40 && sign(_distancia_al_ancla) == direccion) {
        direccion *= -1; 
    }
    
    if (_jugador != noone && !instance_exists(oPlatformer_Transition)) {
        var _dir_hacia_jugador = sign(_jugador.x - x);
        var _mismo_lado = (_dir_hacia_jugador == direccion);
        var _esta_abajo_o_alineado = (_jugador.y >= y - 10); 
        
        var _distancia_h = abs(x - _jugador.x);
        var _distancia_v = abs(y - _jugador.y);
        
        if (_mismo_lado && _esta_abajo_o_alineado && _distancia_h <= rango_vision && _distancia_v <= 60) {
            estado = "persecucion";
        }
    }
} 
else if (estado == "persecucion") {
    _vel_actual = velocidad_persecucion;
    
    if (_jugador != noone) {
        direccion = sign(_jugador.x - x);
        if (direccion == 0) direccion = 1;
        
        if (_jugador.y < y) {
            if (y > altura_inicial_y - 60) {
                vel_vertical = -0.6; 
            } else {
                vel_vertical = 0; 
            }
        } else if (_jugador.y > y) {
            vel_vertical = 0.8; 
        } else {
            vel_vertical = 0;
        }
        
        var _perder_por_punto_ciego = (_jugador.y < y - 20); 
        var _perder_por_distancia  = (distance_to_object(_jugador) > rango_vision * 1.3);
        
        if (_perder_por_punto_ciego || _perder_por_distancia) {
            estado = "patrulla";
            
            ancla_x = x; 
            altura_inicial_y = y; 
            
            direccion = -direccion; 
        }
    }
}

vel_horizontal = direccion * _vel_actual;

efecto_flotar_tiempo += velocidad_onda;
var _vaiven_flotante = sin(efecto_flotar_tiempo) * amplitud_onda;

x += vel_horizontal;
y += vel_vertical + _vaiven_flotante;

if (direccion != 0) {
    image_xscale = direccion * 2;
}

if (_jugador != noone) {
    var _dist_x = abs(x - _jugador.x);
    var _dist_y = abs(y - _jugador.y);
    var _contacto_real = (_dist_x <= 22) && (_dist_y < 24);
    
    if (_contacto_real && _jugador.hitable) {
        if (!instance_exists(oPlatformer_Transition)) {
            
            if (_jugador.cargando_globo && instance_exists(_jugador.globo_cargado_id)) {
                with (_jugador.globo_cargado_id) instance_destroy(); 
                _jugador.cargando_globo = false;
                _jugador.globo_cargado_id = noone;
                _jugador.esta_flotando_globo = false;
                
                _jugador.hitable = false;
                _jugador.alarm = 3 * game_get_speed(gamespeed_fps); 
                _jugador.vel_horizontal = sign(_jugador.x - x) * 4;
                
                estado = "patrulla"; 
                ancla_x = x;
                altura_inicial_y = y;
                direccion = -direccion;
            } 
            else {
                herir_jugador();
            }
        }
    }
}
