var _jugador = instance_find(oPlatformer_Kid, 0);

if (_jugador != noone && place_meeting(x, y, _jugador)) {
    
    if (!_jugador.hitable) {
        
        _jugador.vel_vertical = -14; 
        
        if (_jugador.x < room_width / 2) {
            _jugador.vel_horizontal = 4;
        } else {
            _jugador.vel_horizontal = -4;
        }
    } 
    else {
        var _controlador = instance_find(oPlatformer_Controller, 0); 
        
        if (_controlador != noone && _controlador.state != "game_over") {
            
            herir_jugador(); 
            
            if (global.Platformer_Lives > 0) {
                _jugador.vel_vertical = -12; 
                _jugador.vel_horizontal = sign(room_width / 2 - _jugador.x) * 3;
            }
        }
    }
}
