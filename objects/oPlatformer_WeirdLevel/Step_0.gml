if(place_meeting(x,y,oPlatformer_Kid)){
var _controlador = instance_find(oPlatformer_Controller, 0);

if (_controlador != noone) {
    _controlador.state = "menu";
    _controlador.fase_introduccion = 0;
	_controlador.level_weird = true;
    
    _controlador.alarm[0] = game_get_speed(gamespeed_fps) * 3; 
    global.Platformer_Level_Score = 0;
    global.Platformer_Level_Stars = 0;
}
room_goto(rm_Platformer_lvl_weird);
instance_destroy();

}