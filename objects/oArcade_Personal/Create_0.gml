image_speed = 0;
animacion_especial = false;
image_xscale = 1.5;
image_yscale = 1.5;

textbox_activo_anterior = false;

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
