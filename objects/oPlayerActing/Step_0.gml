if (image_index == 1) {
   fase_reaccion = 1;
}

timer_reaccion += 1;

    switch (fase_reaccion) {
        
        case 1:
            if (timer_reaccion >= 60) {
                image_index = 2;
                fase_reaccion = 2;
                timer_reaccion = 0;
            }
            break;
            
        case 2:
            if (timer_reaccion >= 60) {
                image_index = 3;
                fase_reaccion = 3;
                timer_reaccion = 0;
            }
            break;
            
        case 3:
            if (timer_reaccion >= 120) {
                image_index = 4;
                fase_reaccion = 4;
                timer_reaccion = 0;
				oSave_Check.alarm[0] = game_get_speed(gamespeed_fps) * 1;
            }
            break;
    }
