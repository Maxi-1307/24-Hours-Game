var _hay_jugador = place_meeting(x, y - 1, oPlatformer_Kid);
var _hay_caja    = place_meeting(x, y - 1, oPlatformer_Box);

var _hay_peso = _hay_jugador || _hay_caja;

if (_hay_peso) {
    if (!presionado) {
        presionado = true;
        
        if (permanente) {
            image_index = 1; 
        } else {
            image_index = 3; 
        }
		Effect_Box();
    }
	
} 
else {
    if (presionado && !permanente) {
        presionado = false;
        image_index = 2; 
		Undo_Effect_Box();
    }
}
Comprobar_Combinacion_Meta();
