if (instance_exists(oMusical_Controller)) {
    var _fase = oMusical_Controller.fase_intro;
    var _estado = oMusical_Controller.estado_juego;
    
    if (_estado == "intro") {
        if (_fase == "kris_aparece" || _fase == "caen_letras") {
            sprite_index = sprMusical_Player_Introduction;
            image_index = 0; 
        }
        else if (_fase == "suben_letras") {
            sprite_index = sprMusical_Player_Introduction;
            image_index = 1; 
        }
        exit; 
    }
}

if (global.Musical_Can_Play) {
    
    var _izq_presionada = keyboard_check(global.LeftKey) || keyboard_check(global.DownKey);
    
    var _der_presionada = keyboard_check(global.UpKey) || keyboard_check(global.RightKey);
    
    var _sosteniendo_nota_real = false; 
    if (instance_exists(oMusical_Camera)) {
        _sosteniendo_nota_real = oMusical_Camera.is_holding_note;
    }

    if (_sosteniendo_nota_real) {
        sprite_index = sprMusical_Player_SustainNote;
        image_speed = 0.25; 
    } 
    else if (_izq_presionada) {
        sprite_index = sprMusical_Player_LeftPlaying;
        image_speed = 0.2; 
    } 
    else if (_der_presionada) {
        sprite_index = sprMusical_Player_RightPlaying;
        image_speed = 0.2; 
    } 
    else {
        sprite_index = sprMusical_Player_RightPlaying; 
        image_index = 0; 
        image_speed = 0;
    }
} else {
    image_speed = 0;
}
