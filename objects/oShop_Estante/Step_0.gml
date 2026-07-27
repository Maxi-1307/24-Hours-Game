if (place_meeting(x,y,oPlayer) && global.CanMove) {
    
    var _canasta_activa = noone;
    with (oShop_Basket) {
        if (!en_suelo) _canasta_activa = id;
    }
    
    if (_canasta_activa != noone) {
        var cantidad = array_length(_canasta_activa.items);
        
        if (keyboard_check_pressed(global.ConfirmKey) && !instance_exists(oTextBox)) {
            if (cantidad < _canasta_activa.canasta_max) {
                var _nuevo_item = {
                    id: item_id,
                    nombre: item_nombre,
                    precio: item_precio,
                    frame: item_frame_sprite
                };
                array_push(_canasta_activa.items, _nuevo_item);
            }
        }
        
        if (keyboard_check_pressed(global.CancelKey) && !instance_exists(oTextBox)) {
            if (cantidad > 0) {
                var _ultimo_item = _canasta_activa.items[cantidad - 1];
                
                if (_ultimo_item.id == item_id) {
                    array_pop(_canasta_activa.items);
                }
            }
        }
    }
}
