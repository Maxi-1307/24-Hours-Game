function herir_jugador() {
    var _controlador = instance_find(oPlatformer_Controller, 0);
    var _jugador = instance_find(oPlatformer_Kid, 0);
    
    if (_controlador == noone || _controlador.state == "game_over" || (_jugador != noone && !_jugador.hitable)) {
        exit; 
    }
    
    global.Platformer_Lives -= 1;
    
    if (global.Platformer_Lives > 0) {
        if (_jugador != noone) {
            _jugador.hitable = false;
            _jugador.alarm = 3 * game_get_speed(gamespeed_fps); 
            _jugador.vel_vertical = -4; 
        }
    } else {
        _controlador.state = "game_over";
        global.Platformer_Can_Move = false;
        
        if (_jugador != noone) {
            _jugador.vel_horizontal = 0;
            _jugador.vel_vertical = 0;
        }
        
        _controlador.alarm[1] = 4 * game_get_speed(gamespeed_fps);
    }
}
