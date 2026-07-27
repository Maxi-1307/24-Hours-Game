var _controlador = instance_find(oPlatformer_Controller, 0);

if (_controlador != noone) {
    _controlador.state = "menu";               
    _controlador.fase_introduccion = 0;        
    
    _controlador.alarm = game_get_speed(gamespeed_fps) * 3; 
    
    global.Platformer_Level_Score = 0;
    global.Platformer_Level_Stars = 0;
}

if (!instance_exists(oPlatformer_Transition)) {
    var _trans = instance_create_depth(0, 0, -10000, oPlatformer_Transition);
    
    if (room_exists(room_next(room))) {
        _trans.siguiente_sala = room_next(room);
    } else {
        _trans.siguiente_sala = room; 
        global.Platformer_Level = 1;
    }
}
