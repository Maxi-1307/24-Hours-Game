if (!ha_tocado_suelo) {
    if (!place_meeting(x, y + 1, oWall)) {
        vel_vertical += gravedad;
    } else {
        vel_vertical = 0;
        ha_tocado_suelo = true;
        posicion_ancla_y = y - 12; 
    }

    if (place_meeting(x, y + vel_vertical, oWall)) {
        while (!place_meeting(x, y + sign(vel_vertical), oWall)) {
            y += sign(vel_vertical);
        }
        vel_vertical = 0;
    }
    y += vel_vertical;
    
} else {
    tiempo_flotando += 0.05; 
    
    y = posicion_ancla_y + sin(tiempo_flotando) * 4;
}

var _jugador = instance_find(oPlatformer_Kid, 0);

if (_jugador != noone && place_meeting(x, y, _jugador) && keyboard_check_pressed(global.ConfirmKey)) {
    
    _jugador.hitable = false; 
    _jugador.velocidad_bonus = 3; 
    
    _jugador.alarm = 9 * game_get_speed(gamespeed_fps);
    
    instance_destroy(); 
}
