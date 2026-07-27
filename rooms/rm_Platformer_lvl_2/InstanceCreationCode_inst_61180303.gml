function Comprobar_Combinacion_Meta(){
    var _botones_totales = 0;
    var _botones_pulsados = 0;
    
    with(oPlatformer_Button) {
        if (y == 50) {
            _botones_totales += 1;
            if (presionado == true) {
                _botones_pulsados += 1;
            }
        }
    }
   
    if (_botones_totales >= 4 && _botones_pulsados == _botones_totales) {
        
        if (!instance_exists(oPlatformer_Goal)) {
            instance_create_layer(1695, 205, "Player", oPlatformer_Goal);
        }
        
    } else {
        if (instance_exists(oPlatformer_Goal)) {
            instance_destroy(oPlatformer_Goal);
        }
    }
}
