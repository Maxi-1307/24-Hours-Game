var _jugador = instance_find(oPlatformer_Kid, 0);

if (_jugador != noone && place_meeting(x, y, _jugador) && !tocado && global.Platformer_Level != 3) {
	if(global.Platformer_Level == "??"){
		audio_stop_all();    
	    audio_play_sound(sfx_select, 10, false); 
		instance_destroy(oPlatformer_Controller);
		if (!instance_exists(oPlatformer_Transition)) {
            var transicion = instance_create_depth(0, 0, -10000, oPlatformer_Transition);
            transicion.siguiente_sala = rm_town_arcade; 
			if (instance_exists(oPlayer)) {
				oPlayer.image_angle = 0;
				oPlayer.sprite_index = sprPlayerDown;
			}
	        global.CanMove = true;
	        global.CanInventory = true;
        }
    
	    instance_destroy(); 
	}
    tocado = true;
    fase_victoria = 1;
    
    Level_Score();
    
    global.Platformer_Can_Move = false;
    _jugador.vel_horizontal = 0;
    _jugador.vel_vertical = 0;
}

if (fase_victoria == 1 && _jugador != noone) {
    
    if (zoom_actual > zoom_objetivo) {
        zoom_actual -= velocidad_zoom;
    } else {
        zoom_actual = zoom_objetivo;
        fase_victoria = 2; 
        
        alarm = game_get_speed(gamespeed_fps) * 1.0; 
    }
    
    var _camara = view_camera;
    var _ancho_base = 640; 
    var _alto_base = 480;
    
    var _nuevo_ancho = _ancho_base * zoom_actual;
    var _nuevo_alto = _alto_base * zoom_actual;
    
    camera_set_view_size(_camara, _nuevo_ancho, _nuevo_alto);
    
    var _cam_x = _jugador.x - (_nuevo_ancho / 2);
    var _cam_y = _jugador.y - (_nuevo_alto / 2);
    
    camera_set_view_pos(_camara, _cam_x, _cam_y);
}

if (place_meeting(x, y, oPlatformer_Kid) && !instance_exists(oPlatformer_Ending_Cutscene) && global.Platformer_Level == 3) {
    
    audio_play_sound(sfx_select, 10, false); 
    
    instance_create_layer(0, 0, "Dialogue", oPlatformer_Ending_Cutscene);
    
    instance_destroy(); 
}
