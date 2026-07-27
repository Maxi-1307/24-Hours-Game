if (en_suelo) {
	depth = -y;
    if (place_meeting(x,y,oPlayer) && keyboard_check_pressed(global.ConfirmKey)) {
        
        var ya_tiene_una = false;
        
        with (oShop_Basket) {
            if (!en_suelo) {
                ya_tiene_una = true;
            }
        }
        
        if (ya_tiene_una) {
           if (!instance_exists(oTextBox)) {
               var textbox = instance_create_layer(0, 0, "Dialogue", oTextBox);
                with(textbox) {
                    text[0] = "* Ya tienes una.";
                }
            }
            exit; 
        }
        
        if (global.CanMove) {
            en_suelo = false;
            propietario = oPlayer.id;
        }
    }
} else if (instance_exists(propietario)) {
    depth = propietario.depth - 1; 

    var offset_x = 0;
    var offset_y = 0;

    switch(propietario.sprite_index) {
        case sprPlayerRight:
            offset_y =  propietario.image_yscale;
            break;
            
        case sprPlayerLeft:
            offset_y =  propietario.image_yscale;
            break;
            
        case sprPlayerUp:
            offset_y = -6 * propietario.image_yscale;
            depth = propietario.depth + 1;
            break;
            
        case sprPlayerDown:
            offset_y = -1 * propietario.image_yscale;
            break;
    }

    x = propietario.x + offset_x;
    y = propietario.y + offset_y;
}