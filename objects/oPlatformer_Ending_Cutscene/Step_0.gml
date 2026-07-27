timer += 1;
var _fps = game_get_speed(gamespeed_fps);

if (fase == 0) {
    if (timer >= _fps * 3) {
        if (instance_exists(oPlatformer_Kid)) {
            oPlatformer_Kid.image_index = 2; 
        }
        timer = 0; 
        fase = 2;
    }
}

if (fase == 1) {
    if (timer >= _fps * 3) {
        timer = 0; 
        fase = 2;
    }
}

else if (fase == 2) {
    if (timer >= _fps * 2) { 
        if (instance_exists(oPlatformer_Kid)) {
            oPlatformer_Kid.x = 2962;
            oPlatformer_Kid.y = 15;
            oPlatformer_Kid.image_xscale = -2;   
            oPlatformer_Kid.image_angle = -90;   
            oPlatformer_Kid.image_index = 0;     
        }
        timer = 0;
        fase = 3;
    }
}

else if (fase == 3) {
    if (timer >= _fps * 3) {
        if (instance_exists(oPlatformer_Kid)) {
            oPlatformer_Kid.image_index = 3; 
        }
        timer = 0;
        fase = 4;
    }
}

if (fase == 4) {
    if (timer >= _fps * 1.5) { 
        mostrar_pantalla_negra = true; 
        timer = 0;
        fase = 41; 
    }
}

else if (fase == 41) {
    if (timer >= _fps * 2) { 
        mostrar_ranking = true; 
        mostrar_titulo = true;  
        timer = 0;
        fase = 42; 
    }
}

else if (fase == 42) {
    if (timer >= _fps * 2.5) { 
        mostrar_tabla = true; 
        timer = 0;
        fase = 43; 
    }
}

else if (fase == 43) {
    if (puntaje_animado < puntaje_final) {
        puntaje_animado += 25; 
        
        if (puntaje_animado >= puntaje_final) {
            puntaje_animado = puntaje_final; 
            timer = 0;
            fase = 44; 
        }
    }
}

else if (fase == 44) {
    if (timer >= _fps * 1.5) { 
        mostrar_evaluacion = true; 
        if (es_top_uno) festejo_activo = true; 
        timer = 0;
        fase = 5; 
    }
}

else if (fase == 5) {
    if (festejo_activo) {
        festejo_timer += 1;
        if (instance_exists(oPlayer)) {
            oPlayer.image_angle += 5; 
        }
    }
    
    if (timer >= _fps * 5) {
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
}
