if (place_meeting(x, y, oWall) || place_meeting(x, y, oPlatformer_Box)) {
    instance_destroy();
    exit;
}

var _jugador = instance_find(oPlatformer_Kid, 0);

if (_jugador != noone && place_meeting(x, y, _jugador)) {
    if (_jugador.hitable) {
        if (_jugador.cargando_globo && instance_exists(_jugador.globo_cargado_id)) {
            with (_jugador.globo_cargado_id) instance_destroy();
            _jugador.cargando_globo = false;
            _jugador.globo_cargado_id = noone;
            _jugador.esta_flotando_globo = false;
            _jugador.hitable = false;
            _jugador.alarm[2] = 3 * game_get_speed(gamespeed_fps); 
        } else {
            herir_jugador();
        }
        instance_destroy();
    }
}

if (x < 0 || x > room_width || y < 0 || y > room_height) {
    instance_destroy();
}
