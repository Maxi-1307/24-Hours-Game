var _jugador = instance_find(oPlatformer_Kid, 0);
var _tocando_ahora = false;

if (_jugador != noone) {
    var _dist_x = abs(x - _jugador.x);
    var _dist_y = abs(y - _jugador.y);
    
    if (_dist_x <= 24 && _dist_y <= 24) {
        _tocando_ahora = true;
    }
}

if (_tocando_ahora) {
    timer_soledad = 0; 
    
    if (estado == 0) {
        estado = 1;
        image_index = 1; 
        timer_contacto = 0; 
    } 
    else if (estado == 1) {
        timer_contacto += 1;
        
        var _tres_segundos = game_get_speed(gamespeed_fps) * 3; 
        
        if (timer_contacto >= _tres_segundos) {
            estado = 3;
            image_index = 2; 
            timer_contacto = 0; 
        }
    }
    else if (estado == 3) {
        timer_contacto += 1;
        var _tres_segundos = game_get_speed(gamespeed_fps) * 3;
        
        if (timer_contacto >= _tres_segundos) {
            estado = 1;
            image_index = 1; 
            timer_contacto = 0;
        }
    }
} 
else {
    timer_contacto = 0; 
    
    if (estado != 0) {
        timer_soledad += 1;
        
        var _dos_segundos = game_get_speed(gamespeed_fps) * 2;
        
        if (timer_soledad >= _dos_segundos) {
            estado = 0;
            image_index = 0; 
            timer_soledad = 0;
        }
    }
}
