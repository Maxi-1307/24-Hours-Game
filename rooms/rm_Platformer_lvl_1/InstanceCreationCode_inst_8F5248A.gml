permanente = false;

function Effect_Box(){
    var _caja_en_coordenada = instance_position(1104, 90, oPlatformer_PowerUpBox);
    
    if (_caja_en_coordenada == noone) {
        var box = instance_create_layer(1110, 90, "Player", oPlatformer_PowerUpBox);
        if (instance_exists(box)) {
            box.item = oPlatformer_Balloon;
        }
    }
}
