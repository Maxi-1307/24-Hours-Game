tiempo_flotando += 0.05; 

y = posicion_ancla_y + sin(tiempo_flotando) * 4;

var _jugador = instance_find(oPlatformer_Kid, 0);

if (_jugador != noone && place_meeting(x, y, _jugador)) {
    global.Platformer_Level_Stars += 1;
    instance_destroy();
}
