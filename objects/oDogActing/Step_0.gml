if(instance_exists(oPlayerActing)){
	depth = oPlayerActing.depth - 1;
}

timer += 1;

switch (estado) {
    
    case 0: 
        var _progreso = timer / 120; 
        x = lerp(330, 290, _progreso);
        y = 120;
        
        if (timer >= 120) {
            estado = 1;
            timer = 0;
        }
        break;
        
    case 1:
        x = 290;
        y = 120;
        
        if (timer >= 180) {
            estado = 2;
            timer = 0;
        }
        break;
        
    case 2:
        var _tiempo_total_salto = 150; 
        var _t = timer / _tiempo_total_salto;
        
        x = lerp(x_inicio_salto, -14, _t);
		image_speed = 0;
		sprite_index = sprDogStole
   
        var _altura_salto = 20;
        y = y_inicio_salto - (4 * _altura_salto * _t * (1 - _t));
        
        if (place_meeting(x, y, oPlayerActing)) {
			image_speed = 0;
            image_index = 1;
            
            if (instance_exists(oPlayerActing)) {
                oPlayerActing.image_index = 1;
            }
        }
        
        if (timer >= _tiempo_total_salto) {
            estado = 3;
            timer = 0;
        }
        break;
        
    case 3:
        instance_destroy();
        break;
}
