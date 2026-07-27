permanente = false;

function Effect_Box(){
    var _cantidad_globos = instance_number(oPlatformer_Balloon);
    
    var _coordenada_libre = !position_meeting(1296, 134, oPlatformer_PowerUpBox);
    if (_coordenada_libre && _cantidad_globos <= 2) {
        
        balloon_box = instance_create_layer(1296, 134, "Player", oPlatformer_PowerUpBox);
        balloon_box.item = oPlatformer_Balloon;
    }
}