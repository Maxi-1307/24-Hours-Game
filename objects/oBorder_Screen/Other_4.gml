var nombre_room = room_get_name(room);

var sprite_anterior = borde_sprite;
var proximo_sprite = noone;

if (string_pos("town", nombre_room) > 0) {
    proximo_sprite = sprBorder_Screen_Town;
	if(!audio_is_playing(dreiton)){
		audio_play_sound(dreiton,1,true);
	}
}
else if (string_pos("musical", nombre_room) > 0) {
    proximo_sprite = sprBorder_Screen_Musical;
}

if (borde_sprite != proximo_sprite) {
    borde_anterior = sprite_anterior;
    borde_sprite = proximo_sprite;
    borde_alpha = 0.0;
}
