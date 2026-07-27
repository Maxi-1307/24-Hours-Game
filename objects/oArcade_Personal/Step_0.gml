if (animacion_especial == true) {
    if (image_index >= 4 || image_index < 2) {
        image_index = 2;
    }
}

var textbox_activo_ahora = instance_exists(oTextBox);

if (textbox_activo_anterior && !textbox_activo_ahora) {
    
    animacion_especial = false;
    
    var random_expresion = floor(random(3));
    switch(random_expresion){
        case 0: 
            image_index = 0; 
            image_speed = 0; 
            break;
        case 1: 
            image_index = 1; 
            image_speed = 0; 
            break;
        case 2: 
            image_index = 2; 
            image_speed = 0.08;
            animacion_especial = true; 
            break;
    }
}

textbox_activo_anterior = textbox_activo_ahora;
