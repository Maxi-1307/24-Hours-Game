function AddItem(_item){
    var _item_id = "";
    
    if (is_struct(_item)) {
        var _keys = variable_struct_get_names(global.Items);
        for (var i = 0; i < array_length(_keys); i++) {
            var _key = _keys[i];
            if (variable_struct_exists(_item, "name")) {
                if (_item.name == global.Items[$ _key].name) {
                    _item_id = _key;
                    break;
                }
            }
        }
    } else if (is_string(_item)) {
        _item_id = _item;
    }
    
    if (_item_id == "") {
        show_debug_message("ERROR: No se pudo obtener el ID del item");
        return false;
    }
    
    if (array_length(global.Inventory) < global.InventoryLength) {
        var _nuevo_objeto = {
            item_id: _item_id
        };
        array_push(global.Inventory, _nuevo_objeto);
        return true;
		
    } else {
        var txtbx = instance_create_layer(0, 0, "Dialogue", oTextBox);
        with(txtbx){
            text[0] = _T("inv_full_1");
            text[1] = _T("inv_full_2");
            text[2] = _T("inv_full_3");
            for(var i = 0; i < 3; i++){
                speaker_sprite[i] = noone;
                txtb_snd[i] = sfx_text;
                txtb_color[i] = c_white;
            }
        }
        return false;
    }
}