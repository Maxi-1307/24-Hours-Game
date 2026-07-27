fase_introduccion += 1;

switch(fase_introduccion) {
    case 1:
        alarm[0] = game_get_speed(gamespeed_fps) * 2.5;
        break;
        
    case 2:
        alarm[0] = game_get_speed(gamespeed_fps) * 1.0;
        break;
        
    case 3:
        state = "playing";
        global.Platformer_Can_Move = true;
        break;
}
