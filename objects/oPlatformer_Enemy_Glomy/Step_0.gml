var _en_el_suelo = place_meeting(x, y + 1, oWall) || place_meeting(x, y + 1, oPlatformer_Button);

if (!_en_el_suelo) {
    vel_vertical += gravedad;
} else {
    vel_vertical = 0;
}

var _jugador = instance_find(oPlatformer_Kid, 0);
var _velocidad_actual = velocidad_patrulla;

if (estado == "patrulla") {
    _velocidad_actual = velocidad_patrulla;
    
    if (_jugador != noone && !instance_exists(oPlatformer_Transition)) {
        var _direccion_hacia_jugador = sign(_jugador.x - x);
        var _mismo_lado = (_direccion_hacia_jugador == direccion);
        
        var _ojos_enemigo_y = y - 10; 
        var _misma_altura = (abs(_ojos_enemigo_y - _jugador.y) < 24); 
        
        var _distancia = distance_to_object(_jugador);
        
        if (_mismo_lado && _misma_altura && _distancia <= rango_vision) {
            estado = "embestida";
        }
    }
} 
else if (estado == "embestida") {
    _velocidad_actual = velocidad_embestida;
    
    if (_jugador != noone && distance_to_object(_jugador) > rango_vision * 1.5) {
        estado = "patrulla"; 
    }
}

vel_horizontal = direccion * _velocidad_actual;

var _caja_enfrente = instance_place(x + vel_horizontal, y, oPlatformer_Box);

if (place_meeting(x + vel_horizontal, y, oWall)) {
    direccion *= -1; 
    vel_horizontal = 0;
    if (estado == "embestida") estado = "patrulla"; 
}
else if (_caja_enfrente != noone) {
    if (_caja_enfrente.siendo_cargada) {
    } 
    else if (_caja_enfrente.tiene_globo) {
        with (_caja_enfrente) {
            if (instance_exists(globo_id)) {
                with (globo_id) instance_destroy(); 
            }
            tiene_globo = false;
            globo_id = noone;
        }
    } 
    else {
        direccion *= -1; 
        vel_horizontal = 0;
        if (estado == "embestida") estado = "patrulla"; 
    }
}

if (_en_el_suelo) {
    var _siguiente_bloque_x = x + (direccion * 20);
    var _hay_suelo_adelante = place_meeting(_siguiente_bloque_x, y + 1, oWall) || place_meeting(_siguiente_bloque_x, y + 1, oPlatformer_Button);
    
    if (!_hay_suelo_adelante) {
        direccion *= -1; 
        vel_horizontal = 0;
        
        if (estado == "embestida") {
            estado = "patrulla"; 
        }
    }
}

x += vel_horizontal;

if (place_meeting(x, y + vel_vertical, oWall)) {
    while (!place_meeting(x, y + sign(vel_vertical), oWall)) {
        y += sign(vel_vertical);
    }
    vel_vertical = 0;
}
y += vel_vertical;

if (direccion != 0) {
    image_xscale = direccion * 2;
}

if (_jugador != noone) {
    var _distancia_x = abs(x - _jugador.x);
    var _distancia_y = abs(y - _jugador.y);
    var _contacto_real = (_distancia_x <= 22) && (_distancia_y < 24);
    
    if (_contacto_real && _jugador.hitable) {
        if (!instance_exists(oPlatformer_Transition)) {
            
            if (_jugador.cargando_globo && instance_exists(_jugador.globo_cargado_id)) {
                with (_jugador.globo_cargado_id) {
                    instance_destroy(); 
                }
                _jugador.cargando_globo = false;
                _jugador.globo_cargado_id = noone;
                _jugador.esta_flotando_globo = false;
                
                _jugador.hitable = false;
                _jugador.alarm[2] = 3 * game_get_speed(gamespeed_fps); 
                
                _jugador.vel_horizontal = sign(_jugador.x - x) * 5;
                estado = "patrulla"; 
            } 
            else {
                herir_jugador(); 
            }
        }
    }
}
