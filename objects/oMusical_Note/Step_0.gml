switch(carril) {
    case 0: x = 125; break;
    case 1: x = 147; break;
    case 2: x = 168; break;
    case 3: x = 190; break; 
}

image_index = carril;

if (!global.Musical_Can_Play) exit;
if (nota_fallada) {
    color_cola = make_color_rgb(100, 100, 100);
} else if (siendo_sostenida) {
    color_cola = make_color_rgb(255, 215, 0);
} else {
    switch(carril) {
        case 0: color_cola = make_color_rgb(255, 60, 60);   break;
        case 1: color_cola = make_color_rgb(60, 255, 100);  break;
        case 2: color_cola = make_color_rgb(60, 180, 255);  break;
        case 3: color_cola = make_color_rgb(255, 230, 40);  break;
    }
}

if (siendo_sostenida && !nota_fallada) {
    y = 161;
    altura_cola -= velocidad_caida;
    
    if (altura_cola <= 0) {
        global.Musical_Score += 15;
        if (instance_exists(oMusical_Camera)) oMusical_Camera.is_holding_note = false;
        instance_destroy();
    }
} else {
    y += velocidad_caida;
}

if (!siendo_sostenida && !nota_fallada && y > 175) {
    nota_fallada = true;
    global.Musical_Missed += 1;
    
    if (instance_exists(oMusical_Controller)) {
        oMusical_Controller.color_marco = c_red;
        oMusical_Controller.marco_timer = game_get_speed(gamespeed_fps) * 0.4;
        oMusical_Controller.flash_rojo_alfa = 0.35;
		audio_play_sound(sfx_Musical_GuitarMistake,1,false);
    }
}


if (y - altura_cola > 185) {
    instance_destroy();
}
