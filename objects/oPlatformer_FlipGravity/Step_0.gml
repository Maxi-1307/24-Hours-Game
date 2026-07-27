
var _jugador = instance_place(x, y, oPlatformer_Kid);

if (_jugador != noone) {
    if (keyboard_check_pressed(global.ConfirmKey)) {
        
        _jugador.dir_gravedad *= -1;
        
        _jugador.image_yscale = _jugador.dir_gravedad * 2;

        _jugador.y += _jugador.dir_gravedad * 4;
    }
}
