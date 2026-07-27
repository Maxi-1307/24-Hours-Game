function PlayerWalk(){
	
	var _path_array = argument0;
	var _callback   = argument1;

	with(oPlayer)
	{
	    move_callback = _callback;
	    global.CanMove = false;
	    
	    waypoint_list = _path_array;
	    waypoint_index = 0;

	    state = PLAYER_STATE.AUTO_MOVE;
	}
}