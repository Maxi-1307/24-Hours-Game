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
    
    var _hay_miss = false;
    with (oMusical_Note) {
        if (nota_fallada) {
            _hay_miss = true;
        }
    }

    if (_hay_miss) {
        sprite_index = sprMusical_Player_Miss;
        image_speed = 0.15;
    }
    else if (_sosteniendo_nota_real && _izq_presionada) {
        sprite_index = sprMusical_Player_SustainNoteLeft;
        
        if (image_index >= 1) {
            image_index = 1;
            image_speed = 0;
        } else {
            image_speed = 0.45;
        }
    }
    else if (_sosteniendo_nota_real && _der_presionada) {
        sprite_index = sprMusical_Player_SustainNoteRight;
        
        if (image_index >= 1) {
            image_index = 1;
            image_speed = 0;
        } else {
            image_speed = 0.45;
        }
    }
    else if (_izq_presionada) {
        sprite_index = sprMusical_Player_LeftPlaying;
        
        if (image_index >= 1) {
            image_index = 1;
            image_speed = 0;
        } else {
            image_speed = 0.4;
        }
    }
    else if (_der_presionada) {
        sprite_index = sprMusical_Player_RightPlaying;
        
        if (image_index >= 1) {
            image_index = 1;
            image_speed = 0;
        } else {
            image_speed = 0.4;
        }
    }
    else {
        sprite_index = sprMusical_Player_Idle; 
        image_index = 0; 
        image_speed = 0;
    }
    
} else {
    sprite_index = sprMusical_Player_Idle;
    image_index = 0;
    image_speed = 0;
}