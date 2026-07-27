var _en_el_suelo = place_meeting(x, y + 1, oWall) || place_meeting(x, y + 1, oPlatformer_Button);

if (!_en_el_suelo) {
    vel_vertical += gravedad;
} else {
    vel_vertical = 0;
}

vel_horizontal = direccion * velocidad_caminar;

var _obstaculo_caja = instance_place(x + vel_horizontal, y, oPlatformer_Box);

if (place_meeting(x + vel_horizontal, y, oWall)) {
    direccion *= -1; 
    vel_horizontal = 0;
}
else if (_obstaculo_caja != noone) {
    if (!_obstaculo_caja.siendo_cargada && !_obstaculo_caja.tiene_globo) {
        direccion *= -1; 
        vel_horizontal = 0;
    } 
    else if (_obstaculo_caja.tiene_globo && !_obstaculo_caja.siendo_cargada) {
        with (_obstaculo_caja) {
            if (instance_exists(globo_id)) {
                with (globo_id) instance_destroy();
            }
            tiene_globo = false;
            globo_id = noone;
        }
    }
}

if (_en_el_suelo) {
    var _siguiente_bloque_x = x + (direccion * 20);
    var _hay_suelo_adelante = place_meeting(_siguiente_bloque_x, y + 1, oWall) || place_meeting(_siguiente_bloque_x, y + 1, oPlatformer_Button);
    
    if (!_hay_suelo_adelante) {
        direccion *= -1; 
        vel_horizontal = 0;
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
var _jugador = oPlatformer_Kid;

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
                _jugador.alarm = 3 * game_get_speed(gamespeed_fps); 
                
                _jugador.vel_horizontal = sign(_jugador.x - x) * 4;
            } 
            else {
                herir_jugador(); 
            }
        }
    }
}
