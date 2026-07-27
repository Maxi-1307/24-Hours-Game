var _jugador = instance_find(oPlatformer_Kid, 0); 

if (_jugador != noone) {
    if (place_meeting(x, y+6, _jugador) && _jugador.vel_vertical < 0) {
        
        if (!golpeada) {
            golpeada = true;
            
            _jugador.vel_vertical = 1; 
            
            var _objeto_a_crear = item;
            
            if (_objeto_a_crear == noone) {
                var _azar = irandom(2); 
                if (_azar == 0) _objeto_a_crear = oPlatformer_PowerUp_Cookie;
                if (_azar == 1) _objeto_a_crear = oPlatformer_PowerUp_Tea;
                if (_azar == 2) _objeto_a_crear = oPlatformer_PowerUp_SugarCube;
            }
            
            var _instancia_item = instance_create_layer(x + sprite_width/2, y,"Objects", _objeto_a_crear);
            
            if (instance_exists(_instancia_item)) {
                _instancia_item.vel_vertical = -5; 
            }
            
            instance_destroy();
        }
    }
}
