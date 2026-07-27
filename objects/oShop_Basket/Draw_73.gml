canasta_max = global.InventoryLength - array_length(global.Inventory);
if (!en_suelo && instance_exists(propietario) && global.CanMove) {
    
    var cantidad_items = array_length(items);
    var _estante_cercano = instance_nearest(x, y, oShop_Estante);
    var cerca_de_estante = instance_exists(_estante_cercano) && (distance_to_object(_estante_cercano) < 5);
    
    draw_set_colour(c_white);

    if (cerca_de_estante) {
        draw_text_transformed_colour(197, 197, "[" + key_to_string(global.CancelKey) + "] Return", 0.7, 0.7, 0, c_dkgray, c_dkgray, c_dkgray, c_dkgray, 1);
        draw_text_transformed(196, 196, "[" + key_to_string(global.CancelKey) + "] Return", 0.7, 0.7, 0);
		
        draw_text_transformed_colour(19, 196, "[" + key_to_string(global.ConfirmKey) + "] Pick", 0.7, 0.7, 0, c_dkgray, c_dkgray, c_dkgray, c_dkgray, 1);
        draw_text_transformed(18, 196, "[" + key_to_string(global.ConfirmKey) + "] Pick", 0.7, 0.7, 0);
    } 
    else {
        if (cantidad_items == 0) {
            draw_text_transformed_colour(219, 197, "[" + key_to_string(global.CancelKey) + "] Drop", 0.7, 0.7, 0, c_dkgray, c_dkgray, c_dkgray, c_dkgray, 1);
            draw_text_transformed(218, 196, "[" + key_to_string(global.CancelKey) + "] Drop", 0.7, 0.7, 0);
        }
        
        if (keyboard_check_pressed(global.CancelKey) && !instance_exists(oTextBox)) {
            
            if (cantidad_items == 0) {
                x = x_origen;
                y = y_origen;
                en_suelo = true;
                propietario = noone;
                
                if (!instance_exists(oTextBox)) {
                    var textbox = instance_create_layer(0, 0, "Dialogue", oTextBox);
                    with(textbox) {
                        text[0] = "* Devolviste la cesta.";
                    }
                }
            } 
            else {
                if (!instance_exists(oTextBox)) {
                    var textbox = instance_create_layer(0, 0, "Dialogue", oTextBox);
                    with(textbox) {
                        text[0] = "* Debes vaciarla primero.";
                    }
                }
            }
        }
    }
}
